---
ID: 1893
post_title: 'WIF: Change STS per request'
author: timvw
post_date: 2010-09-05 16:56:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/09/05/wif-change-sts-per-request/
published: true
---
<p>Here is some code that will redirect unauthenticated users to their respective STS (Eg: A user visiting ~/CompanyA/Default.aspx will be asked to authenticate at the STS linked to CompanyA.</p>

<p>Notice that in the enterprise you typically have multiple applications that require this kind of behavior, so you would solve this by establishing trust between your app(s) and your STS + establish trust between your STS and the client STSes.)</p>

[code lang="csharp"]
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
  var regex = @&quot;~/(.*?)/.*&quot;;
  var relativeUrl = VirtualPathUtility.ToAppRelative(rawUrl);
  var match = Regex.Match(relativeUrl, regex);
  return match.Success ? match.Groups[1].Value : &quot;&quot;;
 }

 string GetCompanySts(string companyName)
 {
  if (companyName == &quot;CompanyA&quot;) return @&quot;http://localhost/STS2Site&quot;;
  return @&quot;http://localhost/STSSite&quot;;
 }

 string GetRealm(string companyName)
 {
  var realm = @&quot;http://localhost/RPSite/&quot;;
  if (!string.IsNullOrEmpty(companyName)) realm += companyName +&quot;/&quot;;
  return realm;
 }

 string GetRedirectUrl(string companySts, string realm, string returnUrl)
 {
  var signInRequestMessage = new SignInRequestMessage(new Uri(companySts), realm)
  {
   Context = returnUrl,
   HomeRealm = &quot;timvw&quot;
  };

  return signInRequestMessage.WriteQueryString();
 }
}
[/code]