---
ID: 193
post_title: Exploring CodeDomSerializer
author: timvw
post_date: 2007-08-17 23:45:32
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/08/17/exploring-codedomserializer/
published: true
dsq_thread_id:
  - "1923606182"
---
<p>Sometimes we want absolute control over the code that the visual studio designer generates. Imagine that we have a UserControl with a Number property and instead of the default "this.userControl1.Number = 27;" code that the designer would generate we want it like "this.userControl1.Number = 1 + 3 + 23". In order to achieve this we first have to inform the designer that we want custom serialization. This is done by adding a <a href="http://msdn2.microsoft.com/en-us/library/system.componentmodel.design.serialization.designerserializerattribute.aspx">DesignerSerializerAttribute</a> to our UserControl:</p>
[code lang="csharp"][DesignerSerializer(typeof(PrimeSerializer), typeof(CodeDomSerializer))]
public partial class UserControl1 : UserControl
{
 private int number;

 public int Number
 {
  get { return this.number; }
  set { this.number = value; }
 }

 // ...
}[/code]
<p>And now it's time to implement the PrimeSerializer for the custom assignment code:</p>
[code lang="csharp"]public class PrimeSerializer : CodeDomSerializer
{
 public override object Serialize(IDesignerSerializationManager manager, object value)
 {
  UserControl1 uc = value as UserControl1;
  if (uc == null) { return null; }

  // Instead of implementing all the serialization code, we'll rely on the implementation of the baseclass, namely UserControl
  CodeDomSerializer baseClassSerializer = manager.GetSerializer(typeof(UserControl1).BaseType, typeof(CodeDomSerializer)) as CodeDomSerializer;
  Object codeObject = baseClassSerializer.Serialize(manager, value);

  // The only thing we have to do is find the statement where the assigment to the Number property is made, and replace that...
  CodeStatementCollection codeStatements = codeObject as CodeStatementCollection;
  CodeAssignStatement numberAssignmentStatement = this.FindNumberCodeStatement(codeStatements) as CodeAssignStatement;
  numberAssignmentStatement.Right = new CodeSnippetExpression(GetNumberAsSumOfPrimes(uc.Number));

  return codeObject;
 }

 private CodeStatement FindNumberCodeStatement(CodeStatementCollection codeStatements)
 {
  foreach (CodeStatement codeStatement in codeStatements)
  {
   CodeAssignStatement codeAssignment = codeStatement as CodeAssignStatement;
   if (codeAssignment != null)
   {
    CodePropertyReferenceExpression left = codeAssignment.Left as CodePropertyReferenceExpression;
    if (left != null && left.PropertyName == "Number")
    {
     return codeStatement;
    }
   }
  }

  throw new Exception("The CodeStatement for Number was not found");
 }

 private static string GetNumberAsSumOfPrimes(int number)
 {
  StringBuilder sb = new StringBuilder();

  int[] primes = new int[] { 1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101 };
  for (int i = primes.Length - 1; i >= 0 && number > 0; --i)
  {
   if (primes[i] <= number)
   {
    sb.Insert(0, primes[i]);
    sb.Insert(0, " + ");
    number -= primes[i];
   }
  }

  return sb.ToString().Substring(3);
 }
}[/code]
<p>And now we can look at the generated code in Form1.Designer.cs to verify everything works as expected:</p>
[code lang="csharp"]//
// userControl1
//
this.userControl1.BackColor = System.Drawing.Color.Maroon;
this.userControl1.Location = new System.Drawing.Point(50, 23);
this.userControl1.Name = "userControl11";
this.userControl1.Number = 1 + 3 + 23;
this.userControl1.Size = new System.Drawing.Size(686, 294);
this.userControl1.TabIndex = 0;[/code]
<p>I'll leave the implementation of the Deserialize method up to you. By adding the DesignerSerializer attribute to our <a href="http://msdn2.microsoft.com/en-us/library/system.componentmodel.iextenderprovider.aspx">IExtenderProvider</a> implementations we can get full control over their code generation too :)</p>