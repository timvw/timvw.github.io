---
date: 2022-04-28
title: Notes on using grpc with rust and tonic
---
In the Tonic [examples](https://github.com/hyperium/tonic/tree/master/examples) proto files are used to generated service and client stubs with [tonic_build](https://docs.rs/tonic-build/latest/tonic_build/). 

The [Getting started](https://github.com/hyperium/tonic/) section mentions the following: 
> For IntelliJ IDEA users, please refer to [this](https://github.com/intellij-rust/intellij-rust/pull/8056) and enable org.rust.cargo.evaluate.build.scripts [experimental feature](https://plugins.jetbrains.com/plugin/8182-rust/docs/rust-faq.html#experimental-features).

But in order to have a nice development experience you need some additional tweaks.

You can find the full code here: [https://github.com/timvw/arrow-flightsql-odbc](https://github.com/timvw/arrow-flightsql-odbc)

By default the stubs are generated in ./target/.../build/... Unfortunately [CLion](https://www.jetbrains.com/clion/) does not scan those folders and you don't get to benefit from intellisense.

As a workaround you can generate the stubs in your ./src folder instead. You can do that by configuring the tonic_build in build.rs.

While you are at it, you should also enable the writing of a file_descriptor_set to enable [GRPC Server Reflection](https://github.com/grpc/grpc/blob/master/doc/server-reflection.md) using [tonic-reflection](https://crates.io/crates/tonic-reflection).

#### **`build.rs`**
```rust
use std::env;
use std::path::PathBuf;

fn main() -> Result<(), Box<dyn std::error::Error>> {

    //intellij does not easily find types when not adding code to src
    //tonic_build::compile_protos("proto/Flight.proto")?;
    //tonic_build::compile_protos("proto/FlightSql.proto")?;

    let original_out_dir = PathBuf::from(env::var("OUT_DIR")?);

    let out_dir = "./src";

    tonic_build::configure()
        .out_dir(out_dir)
        .file_descriptor_set_path(original_out_dir.join("flight_descriptor.bin"))
        .compile(&["proto/Flight.proto"], &["proto"])?;

    tonic_build::configure()
        .out_dir(out_dir)
        .file_descriptor_set_path(original_out_dir.join("flight_sql_descriptor.bin"))
        .compile(&["proto/FlightSql.proto"], &["proto"])?;

    Ok(())
}
```

Now you can update your lib.rs and include the generated stubs by referring to their path in ./src instead of the include_proto! macro. Notice that I have also used the include_file_descriptor_set to enable the GRPC Server Reflection:

#### **`src/lib.rs`**
```rust
/*
pub mod arrow_flight_protocol {
    tonic::include_proto!("arrow.flight.protocol"); // The string specified here must match the proto package name
}

pub mod arrow_flight_protocol_sql {
    tonic::include_proto!("arrow.flight.protocol.sql"); // The string specified here must match the proto package name
}
 */

#[path = "arrow.flight.protocol.rs"]
pub mod arrow_flight_protocol;

#[path = "arrow.flight.protocol.sql.rs"]
pub mod arrow_flight_protocol_sql;

pub const FLIGHT_DESCRIPTOR_SET: &[u8] = tonic::include_file_descriptor_set!("flight_descriptor");
pub const FLIGHT_SQL_DESCRIPTOR_SET: &[u8] = tonic::include_file_descriptor_set!("flight_sql_descriptor");
```
Now you can create your server and register the reflection service:

#### **`src/bin/server.rs`**
```rust
let reflection_server = tonic_reflection::server::Builder::configure()
    .register_encoded_file_descriptor_set(arrow_flightsql_odbc::FLIGHT_DESCRIPTOR_SET)
    .register_encoded_file_descriptor_set(arrow_flightsql_odbc::FLIGHT_SQL_DESCRIPTOR_SET)
    .build()?;

Server::builder()
    .add_service(FlightServiceServer::new(myserver))
    .add_service(reflection_server)
    .serve(addr)
    .await?;
```

When your server is running, you can query it:

```bash
grpcurl -vv -plaintext 'localhost:52358' list
```

Outputs:
```text
arrow.flight.protocol.FlightService
grpc.reflection.v1alpha.ServerReflection
```

When diving a little deeper, we find the following:

```bash
grpcurl -vv -plaintext 'localhost:52358' list arrow.flight.protocol.FlightService
```

Outputs:
```text
arrow.flight.protocol.FlightService.DoAction
arrow.flight.protocol.FlightService.DoExchange
arrow.flight.protocol.FlightService.DoGet
arrow.flight.protocol.FlightService.DoPut
arrow.flight.protocol.FlightService.GetFlightInfo
arrow.flight.protocol.FlightService.GetSchema
arrow.flight.protocol.FlightService.Handshake
arrow.flight.protocol.FlightService.ListActions
arrow.flight.protocol.FlightService.ListFlights
```

Happy coding!