---
ID: 1902
post_title: 'WIF: whr parameter is a hint for user Home Realm'
author: timvw
post_date: 2010-09-07 06:39:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/09/07/wif-whr-parameter-is-a-hint-for-user-home-realm/
published: true
---
<p>Yesterday i was reading the <a href="http://claimsid.codeplex.com/">Claims Based Identity & Access Control Guide</a> and learned that the whr parameter is a hint from the application to the STS about the user's STS. So if i look back at the code in  <a href="http://www.timvw.be/wif-change-sts-per-request/">WIF: Change STS per request</a> i should not hardcode the HomeRealm parameter to timvw but use the company name instead.</p>

[code lang="csharp"]
string GetRedirectUrl(string company, string companySts, string realm, string returnUrl)
{
 var signInRequestMessage = new SignInRequestMessage(new Uri(companySts), realm)
 {
  Context = returnUrl,
  HomeRealm = company
 };

 return signInRequestMessage.WriteQueryString();
}
[/code]