---
ID: 425
post_title: >
  Presenting HMAC-Based OTP and Time-Based
  OTP
author: timvw
post_date: 2008-08-22 18:17:32
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/08/22/presenting-hmac-based-otp-and-time-based-otp/
published: true
---
<p>I could not find a .NET implementation of the HMAC-Based One Time Password (HOTP) algorithm as specified in <a href="ftp://ftp.rfc-editor.org/in-notes/rfc4226.txt">RFC4226</a> so i decided to write one myself. Because the <a href="http://www.ietf.org/internet-drafts/draft-mraihi-totp-timebased-00.txt">Time-Based OTP (TOTP)</a> algorithm is an application of HOTP, more specifically: TOTP = HOTP(K, T) with T = (Current Unix time - T0) / Timestep, i have implemented that algorithm too.</p>
<p>You can find both Be.Timvw.Framework.Security.HmacOneTimePassword and Be.Timvw.Framework.Security.TimeOneTimePassword in the <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>. For more information about authentication i would recommend the <a href="http://www.openauthentication.org/specifications">specifications and technicals resources</a> at the <a href="http://www.openauthentication.org/">OATH</a>.</p>