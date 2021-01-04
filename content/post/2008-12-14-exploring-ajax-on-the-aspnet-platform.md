---
date: "2008-12-14T00:00:00Z"
guid: http://www.timvw.be/?p=752
tags:
- ASP.NET
title: Exploring AJAX on the ASP.NET platform
aliases:
 - /2008/12/14/exploring-ajax-on-the-aspnet-platform/
 - /2008/12/14/exploring-ajax-on-the-aspnet-platform.html
---
I finally found some time to experiment with AJAX on the ASP.NET platform. The first technique i looked into was [Partial-Page Rendering](http://msdn.microsoft.com/en-us/library/bb386573.aspx) with controls like [UpdatePanel](http://msdn.microsoft.com/en-us/library/bb386454.aspx). It gave me an awkward feeling but even Dino Esposito, who spent a whole chapter on this technique in his [book](http://www.amazon.com/Programming-Microsoft-ASP-NET-Dino-Esposito/dp/0735625271), seems to [share](http://weblogs.asp.net/despos/archive/2007/09/19/partial-rendering-misses-ajax-architectural-points.aspx) that feeling.

Page methods, public static methods that are decorated with the [WebMethodAttribute](http://msdn.microsoft.com/en-us/library/system.web.services.webmethodattribute.aspx) declared on a [Page](http://msdn.microsoft.com/en-us/library/system.web.ui.page.aspx) are exposed as a WebService method and return the result as [JSON](http://www.json.org/). An easy solution but it comes with the cost that it does not offer much flexibility.

Thanks to the [WebHttpBinding](http://msdn.microsoft.com/en-us/library/system.servicemodel.webhttpbinding.aspx) and [WebInvokeAttribute](http://msdn.microsoft.com/en-us/library/system.servicemodel.web.webinvokeattribute.aspx) the [Windows Communication Foundation](http://msdn.microsoft.com/en-us/library/ms735119.aspx) now supports services that return JSON in a [REST](http://en.wikipedia.org/wiki/Representational_State_Transfer)full call style. This is the technique that i prefer.

[jQuery](http://jquery.com/) is a very sweet library that simplifies JavaScript development seriously and provides an easy way to consume WCF/JSON services easily. Here is an example of a page with a button that by default triggers a postback (supporting all users, even those without JavaScript) but that behavior is overriden with a XMLHTTP request instead once the document is loaded (an enhancement for users with JavaScript)

```javascript
$(document).ready(function() {
	$('#RequestEchoButton').click(function() {
		$.ajax({
			type: 'POST',
			url: 'Default.svc/Echo',
			data: '{}',
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(data) { $('#EchoResultDiv').html(data); },
			error: function(data) { $('#EchoResultDiv').html('Failed to request Echo.'); }
		});
		return false;
	});
});
```

Notice that my Default.svc page uses the [WebServiceHostFactory](http://msdn.microsoft.com/en-us/library/system.servicemodel.activation.webservicehostfactory.aspx)

```xml
<%@ ServiceHost Language="C#" Debug="true" Service="PageServices.Default" Factory="System.ServiceModel.Activation.WebServiceHostFactory" %>
```

Conclusion: Unlike jQuery and WCF, I am not convinced that controls like UpdatePanel and ScriptManager add any value to my toolkit.
