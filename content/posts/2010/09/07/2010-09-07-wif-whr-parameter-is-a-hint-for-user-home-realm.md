---
date: "2010-09-07T00:00:00Z"
guid: http://www.timvw.be/?p=1902
tags:
- sts
- wif
title: 'WIF: whr parameter is a hint for user Home Realm'
---
Yesterday i was reading the [Claims Based Identity & Access Control Guide](http://claimsid.codeplex.com/) and learned that the whr parameter is a hint from the application to the STS about the user's STS. So if i look back at the code in [WIF: Change STS per request](http://www.timvw.be/wif-change-sts-per-request/) i should not hardcode the HomeRealm parameter to timvw but use the company name instead.

```csharp
string GetRedirectUrl(string company, string companySts, string realm, string returnUrl)
{
	var signInRequestMessage = new SignInRequestMessage(new Uri(companySts), realm)
	{
	Context = returnUrl,
	HomeRealm = company
	};

	return signInRequestMessage.WriteQueryString();
}
```
