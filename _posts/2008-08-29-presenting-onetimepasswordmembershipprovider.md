---
ID: 445
post_title: >
  Presenting
  OneTimePasswordMembershipProvider
author: timvw
post_date: 2008-08-29 17:49:41
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/08/29/presenting-onetimepasswordmembershipprovider/
published: true
---
<p>What good is a <a href="http://www.timvw.be/presenting-timeotpclient/">TimeOTP</a> client if you don't have anything to use it with? Last week i have implemented a <a href="http://msdn.microsoft.com/en-us/library/system.web.security.membershipprovider.aspx">MembershipProvider</a> that uses <a href="http://www.timvw.be/presenting-hmac-based-otp-and-time-based-otp/">Time-based One-Time Password</a> to validate the user credentials. Basically, it is a wrapper around an existing MembershipProvider, you get to choose which one via the providerType attribute in the configuration, and requires that it can access the password of users. Here is an example configuration that relies on the SqlMembershipProvider:</p>

[code lang="xml"]<?xml version="1.0"?>
<configuration>
 <connectionStrings>
  <add name="MyDatabase"
         connectionString="xxxxx"
         providerName="System.Data.SqlClient"/>
 </connectionStrings>
 <system.web>
  <membership defaultProvider="OTPMembershipProvider">
   <providers>
    <add connectionStringName="MyDatabase"
            enablePasswordRetrieval="true"
            enablePasswordReset="true"
            requiresQuestionAndAnswer="false"
            applicationName="/DemoOTP"
            requiresUniqueEmail="false"
            passwordFormat="Clear"
            maxInvalidPasswordAttempts="5"
            minRequiredPasswordLength="7"
            minRequiredNonalphanumericCharacters="1"
            passwordAttemptWindow="10"
            passwordStrengthRegularExpression=""
            name="OTPMembershipProvider"
            type="Be.Timvw.Framework.Web.Security.OneTimePasswordMembershipProvider, Be.Timvw.Framework.Web"
            providerType="System.Web.Security.SqlMembershipProvider, System.Web" />
    </providers>
   </membership>
   <authentication mode="Forms" />
    <authorization>
     <allow users="timvw"/>
     <deny users="*"/>
    </authorization>
 </system.web>
</configuration>[/code]

<p>While i was writing unittests i ran into a couple of issues: </p>
<ul>
<li><a href="http://www.nmock.org/">NMock</a> seemingly only works with interfaces so i had to rip out an interface out of the abstract base class and wrap that in a MockMembershipProvider.</li>
<li>Settings expectations for output parameters can be achieved with a SetNameParameterAction as described <a href="http://www.pashabitz.com/PermaLink,guid,02e35fa6-c729-43a8-85c3-8c05df7a4aa8.aspx">here</a>.</li>
</ul>

<p>Anyway, you can find the implementation of the MembershipProvider in <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a> and <a href="http://www.timvw.be/wp-content/code/csharp/DemoOTP.zip">download the demo webapplication</a>.</p>