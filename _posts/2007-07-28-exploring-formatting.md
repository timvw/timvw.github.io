---
ID: 184
post_title: 'Exploring formatting&#8230;'
author: timvw
post_date: 2007-07-28 00:08:56
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/07/28/exploring-formatting/
published: true
---
<p>In the documentation you can read the following for <a href="http://msdn2.microsoft.com/en-us/library/system.globalization.cultureinfo.aspx">CultureInfo</a>:</p>

<blockquote>
<div>
The CultureInfo class holds culture-specific information, such as the associated language, sublanguage, country/region, calendar, and cultural conventions. This class also provides access to culture-specific instances of DateTimeFormatInfo, NumberFormatInfo, CompareInfo, and TextInfo. These objects contain the information required for culture-specific operations, such as casing, formatting dates and numbers, and comparing strings.
</div>
</blockquote>

<p>First i'll initialize an instance of a customized CultureInfo and install it in the current thread:</p>

[code lang="csharp"]CultureInfo appCultureInfo = new CultureInfo("en-US");
appCultureInfo.NumberFormat.NumberDecimalSeparator = ".";
appCultureInfo.NumberFormat.NumberGroupSeparator = " ";
appCultureInfo.NumberFormat.NumberDecimalDigits = 2;
appCultureInfo.NumberFormat.CurrencySymbol = "€";
Thread.CurrentThread.CurrentCulture = appCultureInfo;[/code]

<p><b>Note: </b>The culture in Thread.CurrentThread.CurrentUICulture is only used by the Resource Manager to lookup culture-specific resources at run-time. Since we're not playing with resources, we don't have to care about this one.</p>

<p>If you don't provide the desired format specifier, you will get the generic format specifier "G" ( Standard <a href="http://msdn2.microsoft.com/en-us/library/dwhawy9k(VS.71).aspx">Numeric</a>, <a href="http://msdn2.microsoft.com/en-us/library/az4se3k1(VS.71).aspx">DateTime</a>, <a href="http://msdn2.microsoft.com/en-us/library/c3s1ez6e(VS.71).aspx">Enumeration</a> Format Strings) And now it's time for a little demo:</p>

[code lang="csharp"]public double SomeValue
{
 get { return 12345.6789; }
}

private void Form1_Load(object sender, EventArgs e)
{
 label1.Text = "default to generic format: " + SomeValue.ToString();
 label2.Text = "numeric format: " + SomeValue.ToString("N");
 label3.Text = String.Format("currency format: {0:C}", SomeValue);
 label4.DataBindings.Add("Text", this, "SomeValue", true, DataSourceUpdateMode.Never, string.Empty, "P");

 this.Column1.DefaultCellStyle.Format = "E1";
 this.Column1.DataPropertyName = "SomeValue";
 this.dataGridView1.AutoGenerateColumns = false;
 this.dataGridView1.DataSource = new Form1[] { this };
}
[/code]
<br/>
<img src="http://www.timvw.be/wp-content/images/formatting-01.gif" alt=""/>

<p>Another important interface for formatting is <a href="http://msdn2.microsoft.com/en-us/library/system.IFormattable.aspx">IFormattable</a> which provides functionality to format the value of an object into a string representation. Put simply, it allows you to define your own format specifiers. Here is an example that allows the user to build his own representation of a Person:</p>
[code lang="csharp"]class Person : IFormattable
{
 // omitted the code for 4 properties: Id, Name, Title and Birthday

 public override string ToString()
 {
  return ToString("{Id}, {Name}", null);
 }

 public string ToString(string format, IFormatProvider formatProvider)
 {
  string actualFormat = format;

  string[] replacements = new string[] { "Id", "Name", "Title", "Birthday" };
  for (int i = 0; i < replacements.Length; ++i)
  {
   actualFormat = actualFormat.Replace(replacements[i], i.ToString());
  }

  return string.Format(actualFormat, this.id, this.name, this.title, this.birthday);
 }
}

private void Form1_Load(object sender, EventArgs e)
{
 List<person> persons = new List<person>();
 persons.Add(new Person(1, new DateTime(1980, 4, 30), "Tim", "Sir"));
 persons.Add(new Person(2, new DateTime(1974, 4, 9), "Jenna", "Miss"));

 this.comboBox1.FormatString = "{Name} born on {Birthday}";
 this.comboBox1.FormattingEnabled = true;
 this.comboBox1.DataSource = persons;
}[/code]
<br/>
<img src="http://www.timvw.be/wp-content/images/formatting-02.gif" alt=""/>