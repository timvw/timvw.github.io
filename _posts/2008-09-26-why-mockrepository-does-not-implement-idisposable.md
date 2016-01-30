---
ID: 622
post_title: >
  Why MockRepository does not implement
  IDisposable
author: timvw
post_date: 2008-09-26 17:31:35
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/26/why-mockrepository-does-not-implement-idisposable/
published: true
---
<p>Earlier this week i was experimenting with <a href="http://ayende.com/projects/rhino-mocks.aspx">Rhino Mocks</a> and i was wondering why the MockRepository does not implement <a href="http://msdn.microsoft.com/en-us/library/system.idisposable.aspx">IDisposable</a> unlike most other mocking frameworks for .NET</a>. After a bit of searching i found out that (<a href="http://groups.google.com/group/RhinoMocks/browse_thread/thread/c1a89f58d512d03e/48ca85746276c97b?lnk=gst&q=idisposable+mockrepository&pli=1">here</a>) originally the MockRepository did implement the interface, but that the implementation was removed because it is can be painful (hiding the original exception) when unexpected exceptions are thrown.</p>

<p>I really like the API. Here is a simple example and notice that i did not have to provide the method name (as in the string "GetTime") for the excepted calls.:</p>

[code lang="csharp"][TestClass]
public class WhenTestingApplicabilityOfContract
{
 private MockRepository repository;

 [TestInitialize]
 public void BeforeEachMethod()
 {
  this.repository = new MockRepository();
 }

 [TestCleanup]
 public void AfterEachMethod()
 {
  this.repository.VerifyAll();
 }

 [TestMethod]
 public void ShouldReturnTrueWhenTimeInPeriodOfContract()
 {
  ITimeProvider provider = this.repository.StrictMock<itimeProvider>();

  using(this.repository.Record())
  {
   Expect.Call(provider.GetTime()).Return(new DateTime(2007, 01, 01));
   Expect.Call(provider.GetTime()).Return(new DateTime(2008, 01, 01));
   Expect.Call(provider.GetTime()).Return(new DateTime(2009, 01, 01));
  }

  using(this.repository.Playback())
  {
   Contract contract = new Contract(provider, new DateTime(2008, 01, 01), new DateTime(2008, 12, 31));

   Assert.IsFalse(contract.IsApplicable(), "not applicablein 2007");
   Assert.IsTrue(contract.IsApplicable(), "applicable in 2008");
   Assert.IsFalse(contract.IsApplicable(), "not applicable in 2009");
  }
 }
}[/code]