---
date: 2022-06-16
title: Parsing with Pest
---
A couple of weeks ago I was working on [datafusion-catalogprovider-glue](https://github.com/datafusion-contrib/datafusion-catalogprovider-glue), a catalogprovider for [Datafusion](https://github.com/apache/arrow-datafusion) sourcing from [AWS Glue](https://aws.amazon.com/glue).

The [AWS SDK for Rust](https://github.com/awslabs/aws-sdk-rust) returns an UTF-8 string as the datatype value for each [column](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-api-catalog-tables.html#aws-glue-api-catalog-tables-Column) in a table. A [crawler](https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html) will use [datatypes](https://docs.aws.amazon.com/athena/latest/ug/data-types.html) which are supported by [Athena](https://aws.amazon.com/athena).

Parsing the initial data types was pretty simple:

```rust
match glue_type {
    "int" => Ok(DataType::Int32),
    "boolean" => Ok(DataType::Boolean),
    "bigint" => Ok(DataType::Int64),
    "float" => Ok(DataType::Float32),
    ...
}
```

Support for decimal and arrays remained simple with some [regular expressions](https://docs.rs/regex/latest/regex/) and recursion:

```rust
static ref DECIMAL_RE: Regex = Regex::new("^decimal\\((?P<precision>\\d+)\\s*,\\s*(?P<scale>\\d+)\\)$").unwrap();

static ref ARRAY_RE: Regex = Regex::new("^array<(?P<array_type>.+)>$").unwrap();

_ => {
    if let Some(decimal_cg) = DECIMAL_RE.captures(glue_type) {
        let precision = decimal_cg
            .name("precision")
            .unwrap()
            .as_str()
            .parse()
            .unwrap();
        let scale = decimal_cg.name("scale").unwrap().as_str().parse().unwrap();
        Ok(DataType::Decimal(precision, scale))
    } else if let Some(array_cg) = ARRAY_RE.captures(glue_type) {
        let array_type = array_cg.name("array_type").unwrap().as_str();
        let field = Self::map_to_arrow_field(glue_name, array_type)?;
        Ok(DataType::List(Box::new(field)))
    ...
```

But then I also needed to support maps and structs which require matching nested constructs with [balancing groups](https://www.regular-expressions.info/balancing.html). And I gave up :)

I made the decision to leverage a proper parser, wrote an [EBNF](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form) grammar but was unable to find a good parser-generator for Rust and decided to use [Pest](https://pest.rs/), a general purpose parser written in Rust with a focus on accessibility, correctness, and performance. 

Following the examples in the [Pest book](https://pest.rs/book/) made it easy to write the [parsing expression grammar](https://en.wikipedia.org/wiki/Parsing_expression_grammar), PEG: [glue_datatype.pest](https://github.com/timvw/datafusion-catalogprovider-glue/blob/main/src/glue_data_type_parser/glue_datatype.pest). Using the [Pest plugin](https://plugins.jetbrains.com/plugin/12046-pest) for IDEA made it even easier:

```pest
DataType = _{ SimpleType | ArrayType | MapType | StructType }
SimpleType = _{ TinyInt | SmallInt | Int | Boolean | BigInt | Float | Double | Binary | Date | Timestamp | String | Char | Varchar | Decimal }

TinyInt = { "tinyint" }
SmallInt = { "smallint" }
Int = { "int" | "integer" }

Decimal = { "decimal(" ~ number ~ "," ~ number ~ ")" }
ArrayType = { "array<" ~ DataType ~ ">" }
MapType = { "map<" ~ DataType ~ "," ~ DataType ~ ">" }
StructType = { "struct<" ~ structFields ~ ">" }
structFields = _{ structField ~ ("," ~ structField)* }
structField = { ident ~ ":" ~ DataType }
```

I decided to first [parse](https://github.com/timvw/datafusion-catalogprovider-glue/blob/8af1eded1993abf3602685ba1bb66cc5d687dfeb/src/glue_data_type_parser/mod.rs#L49) this into a Rust enum, [GlueDataType](https://github.com/timvw/datafusion-catalogprovider-glue/blob/8af1eded1993abf3602685ba1bb66cc5d687dfeb/src/glue_data_type_parser/mod.rs#L11) and only then [map](https://github.com/timvw/datafusion-catalogprovider-glue/blob/8af1eded1993abf3602685ba1bb66cc5d687dfeb/src/catalog_provider/glue.rs#L384) from this enum to Datafusion/Arrow datatypes.

In summary this exercise felt like a walk in the park ;)

