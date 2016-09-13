---
ID: 112
post_title: >
  Simple serialization and deserialization
  of public class members
author: timvw
post_date: 2006-04-21 02:19:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/04/21/simple-serialization-and-deserialization-of-public-class-members/
published: true
---
<p>Here is a simple generic class that allows you to serialize classes (well, their public members) into XML and deserialize the XML to objects again. Make sure the class (or struct) has a parameterless constructor and that all the members that you want to serialize are public. Here is the code:</p>
[code lang="csharp"]
public class SimpleSerializer<t>
{
 public String Serialize(T o)
 {
  using(MemoryStream m = new MemoryStream())
  {
   XmlSerializer s = new XmlSerializer(o.GetType());
   s.Serialize(m, o);
   return Encoding.UTF8.GetString(m.ToArray());
  }
 }

 public T Deserialize(String xml)
 {
  using (MemoryStream m = new MemoryStream(Encoding.UTF8.GetBytes(xml)))
  {
   XmlSerializer s = new XmlSerializer(typeof(T));
   return (T)s.Deserialize(m);
  }
 }
}[/code]

<p>Here is a simple example of a class that will be serialized:</p>
[code lang="csharp"]
public struct Person {
  public String firstname;
  public String lastname;

  public Person(String firstname, String lastname) {
    this.firstname = firstname;
    this.lastname = lastname;
  }
}
[/code]

<p>And finally, a simple console application that demonstrates how it works:</p>
[code lang="csharp"]
class Program {
  static void Main(string[] args) {
    Person p1 = new Person("Tim", "Van Wassenhove");
    SimpleSerializer<person> ss = new SimpleSerializer<person>();

    String xml = ss.Serialize(p1);
    Console.WriteLine("serialized:\n" + xml);

    Person p2 = ss.Deserialize(xml);
    Console.WriteLine("unserialized name: " + p2.firstname);

    Console.WriteLine("Press any key to continue...");
    Console.ReadKey();
  }
}
[/code]