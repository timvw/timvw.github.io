---
ID: 960
post_title: 'POC: Moq API adapter for Rhino Mocks'
author: timvw
post_date: 2009-04-03 08:21:16
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/04/03/poc-moq-api-adapter-for-rhino-mocks/
published: true
---
<p>One of my main concerns with third party software, and software in general, is maintainability. The Rhino Mocks project has been out there for a couple of years now and i'm pretty confident that it won't go away anytime soon. The Moq project is a lot younger and will have to proove that it can stay alive...</p>

<p>Anyway, because most people seem to digg the Moq API i have decided to write an adapter that provides the same API using Rhino Mocks. Here are some simple examples:</p>

[code lang="csharp"]public interface IEcho
{
 string Echo(string input);
}

[TestClass]
public class MockTests
{
 [TestMethod]
 public void ShouldBeAbleToReturnObject()
 {
  // Arrange
  Mock<iecho> sut = new Mock<iecho>();

  // Act
  IEcho echo = sut.Object;

  // Assert
  Assert.IsNotNull(echo);
  Assert.IsInstanceOfType(echo, typeof(IEcho));
 }

 [TestMethod]
 public void ShouldBeAbleToSetupAnAction()
 {
  // Arrange
  Mock<iecho> sut = new Mock<iecho>();

  sut.Setup(delegate(IEcho echo)
  {
   echo.Echo("tim");
  }).Returns("tim");

  // Act
  string result = sut.Object.Echo("tim");

  // Assert
  Assert.AreEqual("tim", result);
 }

 [TestMethod]
 public void ShouldBeAbleToVerifyAnAction()
 {
  // Arrange
  Mock<iecho> sut = new Mock<iecho>();

  // Act
  sut.Object.Echo("tim");

  // Assert
  sut.Verify(delegate(IEcho echo)
  {
   echo.Echo("tim");
  });
 }

 [TestMethod]
 [ExpectedException(typeof(ExpectationViolationException))]
 public void ShouldBeAbleToVerifyAnActionThatDidNotHappen()
 {
  // Arrange
  Mock<iecho> sut = new Mock<iecho>();

  // Act
  sut.Object.Echo("tim");

  // Assert
  sut.Verify(delegate(IEcho echo)
  {
   echo.Echo("mike");
  });
 }

 [TestMethod]
 public void ShouldBeAbleToRaiseAnEvent()
 {
  // Arrange
  Mock<iecho> sut = new Mock<iecho>();
  bool wasCalled = false;

  sut.Object.EchoCompleted += delegate(object sender, EventArgs e)
  {
   if (sender == sut && e == EventArgs.Empty) wasCalled = true;
  };

  //  Act
  sut.Raise(delegate(IEcho echo) { echo.EchoCompleted += null; }, sut, EventArgs.Empty);

  // Assert
  Assert.IsTrue(wasCalled);
 }

 [TestMethod]
 [ExpectedException(typeof(ArgumentException))]
 public void ShouldBeAbleToThrowAnException()
 {
  // Arrange
  Mock<iecho> sut = new Mock<iecho>();

  sut.Setup(delegate(IEcho echo)
  {
   echo.Echo("tim");
  }).Throws<argumentException>();

  // Act
  sut.Object.Echo("tim");
 }
}[/code]

<p>Here is the actual code for this simplistic adapter:</p>

[code lang="csharp"]public class Mock<t> where T : class
{
 private readonly T mockedObject;

 public Mock()
 {
  this.mockedObject = MockRepository.GenerateStub<t>();
 }

 public T Object
 {
  get { return this.mockedObject; }
 }

 public Setup<object, T> Setup(Action<t> action)
 {
  return new Setup<object, T>(RhinoMocksExtensions.Stub(this.mockedObject, action));
 }

 public Setup<r, T> Setup<r>(Delegates.Function<r, T> action)
 {
  return new Setup<r, T>(RhinoMocksExtensions.Stub(this.mockedObject, action));
 }

 public void Verify(Action<t> action)
 {
  RhinoMocksExtensions.AssertWasCalled(this.mockedObject, action);
 }

 public void Raise(Action<t> eventSubscription, params object[] args)
 {
  RhinoMocksExtensions.Raise(this.mockedObject, eventSubscription, args);
 }

 public Setup<r, T> Throws<e>() where E : Exception, new()
 {
  return new Setup<r, T>(this.options.Throw(new E()));
 }
}

public class Setup<r, T>
{
 private readonly IMethodOptions<r> options;

 public Setup(IMethodOptions<r> options)
 {
  this.options = options;
 }

 public Setup<r, T> Returns(R objToReturn)
 {
  return new Setup<r, T>(this.options.Return(objToReturn));
 }

 public Setup<r, T> Returns(Delegates.Function<r, T> action)
 {
  return new Setup<r, T>(this.options.Do(action));
 }
}[/code]