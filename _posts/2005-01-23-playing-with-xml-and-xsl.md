---
title: Playing with XML and XSL
layout: post
tags:
  - PHP
  - XML
---
```php  
// add stuff to an xml document in php4
$doc = domxml_open_mem($xml);
$root = $doc->document_element();
$inner = $doc->create_element('inner');
$root = $root->append_child($inner);

// add stuff to an xml document in php5
$doc = new DomDocument('1.0', 'UTF-8');
$doc->loadXML($xml);
$root = $doc->getelementsByTagName('resultset')->item(0);
$inner = $doc->createElement'inner');
$root = $root->appendChild($inner); 
```

[XHTML](http://www.w3.org/TR/xhtml1/) does not allow to have an empty list, <ul></ul>. Therefore we need to test first if there are any nodes we want to put in that list. The code to do this looks like:

```xml
<xsl:for-each select="//resultset/entity">

  <div class="mainitem">
    <div class="maintitle">
      <xsl:value-of select="title"/>
    </div>
    <div class="maincontent">
      <xsl:if test="count(items/item) > 0">
        <ul>
          <xsl:for-each select="items/item"> 
            <li>
              <a href="{link}"><xsl:value-of select="title"/></a>
            </li>
          </xsl:for-each> 
        </ul> 
      </xsl:if>
    </div>
  </div> 
</xsl:for-each>
```
