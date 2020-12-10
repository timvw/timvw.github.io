---
title: 'WIF: Change STS per request'
layout: post
guid: http://www.timvw.be/?p=1893
categories:
  - Uncategorized
tags:
  - sts
  - wif
---
Here is some code that will redirect unauthenticated users to their respective STS (Eg: A user visiting ~/CompanyA/Default.aspx will be asked to authenticate at the STS linked to CompanyA.

Notice that in the enterprise you typically have multiple applications that require this kind of behavior, so you would solve this by establishing trust between your app(s) and your STS + establish trust between your STS and the client STSes.)

```csharp
public class Global : HttpApplication
{
	protected void wSFederationAuthenticationModule_RedirectingToIdentityProvider(object sender, RedirectingToIdentityProviderEventArgs e)
	{
		e.Cancel = true;
		RedirectToCompanySts();
	}

	void RedirectToCompanySts()
	{
		var httpContext = HttpContext.Current;
		var rawUrl = httpContext.Request.RawUrl;

		var returnUrl = rawUrl;
		var companyName = ExtractCompanyName(rawUrl);
		var companySts = GetCompanySts(companyName);
		var realm = GetRealm(companyName);
		var redirectUrl = GetRedirectUrl(companySts, realm, returnUrl);

		httpContext.Response.Redirect(redirectUrl, false);
		httpContext.ApplicationInstance.CompleteRequest();
	}

	string ExtractCompanyName(string rawUrl)
	{
		var regex = @"~/(.\*?)/.\*";
		var relativeUrl = VirtualPathUtility.ToAppRelative(rawUrl);
		var match = Regex.Match(relativeUrl, regex);
		return match.Success ? match.Groups[1].Value : "";
	}

	string GetCompanySts(string companyName)
	{
		if (companyName == "CompanyA") return @"http://localhost/STS2Site";
		return @"http://localhost/STSSite";
	}

	string GetRealm(string companyName)
	{
		var realm = @"http://localhost/RPSite/";
		if (!string.IsNullOrEmpty(companyName)) realm += companyName +"/";
		return realm;
	}

	string GetRedirectUrl(string companySts, string realm, string returnUrl)
	{
		var signInRequestMessage = new SignInRequestMessage(new Uri(companySts), realm)
		{
			Context = returnUrl,
			HomeRealm = "timvw"
		};

		return signInRequestMessage.WriteQueryString();
	}
}
```
