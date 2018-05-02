---
id: 425
title: Presenting HMAC-Based OTP and Time-Based OTP
date: 2008-08-22T18:17:32+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=425
permalink: /2008/08/22/presenting-hmac-based-otp-and-time-based-otp/
tags:
  - 'C#'
---
I could not find a .NET implementation of the HMAC-Based One Time Password (HOTP) algorithm as specified in [RFC4226](ftp://ftp.rfc-editor.org/in-notes/rfc4226.txt) so i decided to write one myself. Because the [Time-Based OTP (TOTP)](http://www.ietf.org/internet-drafts/draft-mraihi-totp-timebased-00.txt) algorithm is an application of HOTP, more specifically: TOTP = HOTP(K, T) with T = (Current Unix time -- T0) / Timestep, i have implemented that algorithm too.

You can find both Be.Timvw.Framework.Security.HmacOneTimePassword and Be.Timvw.Framework.Security.TimeOneTimePassword in the [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework). For more information about authentication i would recommend the [specifications and technicals resources](http://www.openauthentication.org/specifications) at the [OATH](http://www.openauthentication.org/).