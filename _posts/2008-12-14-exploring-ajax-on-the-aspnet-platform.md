---
ID: 752
post_title: Exploring AJAX on the ASP.NET platform
author: timvw
post_date: 2008-12-14 16:50:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/12/14/exploring-ajax-on-the-aspnet-platform/
published: true
---
<p>I finally found some time to experiment with AJAX on the ASP.NET platform. The first technique i looked into was <a href="http://msdn.microsoft.com/en-us/library/bb386573.aspx">Partial-Page Rendering</a> with controls like <a href="http://msdn.microsoft.com/en-us/library/bb386454.aspx">UpdatePanel</a>. It gave me an awkward feeling but even Dino Esposito, who spent a whole chapter on this technique in his <a href="http://www.amazon.com/Programming-Microsoft-ASP-NET-Dino-Esposito/dp/0735625271">book</a>, seems to <a href="http://weblogs.asp.net/despos/archive/2007/09/19/partial-rendering-misses-ajax-architectural-points.aspx">share</a> that feeling.</p>

<p>Page methods, public static methods that are decorated with the <a href="http://msdn.microsoft.com/en-us/library/system.web.services.webmethodattribute.aspx">WebMethodAttribute</a> declared on a <a href="http://msdn.microsoft.com/en-us/library/system.web.ui.page.aspx">Page</a> are exposed as a WebService method and return the result as <a href="http://www.json.org/">JSON</a>. An easy solution but it comes with the cost that it does not offer much flexibility.</p>

<p>Thanks to the <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.webhttpbinding.aspx">WebHttpBinding</a> and <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.web.webinvokeattribute.aspx">WebInvokeAttribute</a> the <a href="http://msdn.microsoft.com/en-us/library/ms735119.aspx">Windows Communication Foundation</a> now supports services that return JSON in a <a href="http://en.wikipedia.org/wiki/Representational_State_Transfer">REST</a>full call style. This is the technique that i prefer.</p>

<p><a href="http://jquery.com/">jQuery</a> is a very sweet library that simplifies JavaScript  development seriously and provides an easy way to consume WCF/JSON services easily. Here is an example of a page with a button that by default triggers a postback (supporting all users, even those without JavaScript) but that behavior is overriden with a XMLHTTP request instead once the document is loaded (an enhancement for users with JavaScript):</p>

[code lang="javascript"]$(document).ready(function() {
 $('#RequestEchoButton').click(function() {
  $.ajax({
   type: 'POST',
   url: 'Default.svc/Echo',
   data: '{}',
   contentType: 'application/json; charset=utf-8',
   dataType: 'json',
   success: function(data) {
    $('#EchoResultDiv').html(data);
   },
   error: function(data) {
    $('#EchoResultDiv').html('Failed to request Echo.');
   }
  });
  return false;
 });
});[/code]

<p>Notice that my Default.svc page uses the <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.activation.webservicehostfactory.aspx">WebServiceHostFactory</a>:</p>

[code lang="xml"]<%@ ServiceHost
 Language="C#"
 Debug="true"
 Service="PageServices.Default"
 Factory="System.ServiceModel.Activation.WebServiceHostFactory"
%>[/code]

<p>Conclusion: Unlike jQuery and WCF, I am not convinced that controls like UpdatePanel and ScriptManager add any value to my toolkit.</p>