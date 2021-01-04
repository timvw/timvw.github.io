---
date: "2008-08-29T00:00:00Z"
guid: http://www.timvw.be/?p=445
tags:
- CSharp
title: Presenting OneTimePasswordMembershipProvider
---
What good is a [TimeOTP](http://www.timvw.be/presenting-timeotpclient/) client if you don't have anything to use it with? Last week i have implemented a [MembershipProvider](http://msdn.microsoft.com/en-us/library/system.web.security.membershipprovider.aspx) that uses [Time-based One-Time Password](http://www.timvw.be/presenting-hmac-based-otp-and-time-based-otp/) to validate the user credentials. Basically, it is a wrapper around an existing MembershipProvider, you get to choose which one via the providerType attribute in the configuration, and requires that it can access the password of users. Here is an example configuration that relies on the SqlMembershipProvider

```xml
<?xml version="1.0"?>
<configuration>
	<connectionStrings>
		<add name="MyDatabase" connectionString="xxxxx" providerName="System.Data.SqlClient"/>
	</connectionStrings>
	
	<system.web>
		<membership defaultProvider="OTPMembershipProvider"> <providers> <add connectionStringName="MyDatabase" enablePasswordRetrieval="true" enablePasswordReset="true" requiresQuestionAndAnswer="false" applicationName="/DemoOTP" requiresUniqueEmail="false" passwordFormat="Clear" maxInvalidPasswordAttempts="5" minRequiredPasswordLength="7" minRequiredNonalphanumericCharacters="1" passwordAttemptWindow="10" passwordStrengthRegularExpression="" name="OTPMembershipProvider" type="Be.Timvw.Framework.Web.Security.OneTimePasswordMembershipProvider, Be.Timvw.Framework.Web" providerType="System.Web.Security.SqlMembershipProvider, System.Web" /> </providers> </membership>
		<authentication mode="Forms" />
		<authorization>
			<allow users="timvw"/>
			<deny users="*"/>
		</authorization>
	</system.web>
</configuration>
```

While i was writing unittests i ran into a couple of issues

* [NMock](http://www.nmock.org/) seemingly only works with interfaces so i had to rip out an interface out of the abstract base class and wrap that in a MockMembershipProvider.
* Settings expectations for output parameters can be achieved with a SetNameParameterAction as described [here](http://www.pashabitz.com/PermaLink,guid,02e35fa6-c729-43a8-85c3-8c05df7a4aa8.aspx).

Anyway, you can find the implementation of the MembershipProvider in [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework) and [download the demo webapplication](http://www.timvw.be/wp-content/code/csharp/DemoOTP.zip).
