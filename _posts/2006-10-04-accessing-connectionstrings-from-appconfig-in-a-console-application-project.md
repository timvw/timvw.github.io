---
ID: 5
post_title: >
  Accessing ConnectionStrings from
  App.config in a Console Application
  Project
author: timvw
post_date: 2006-10-04 17:07:15
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/10/04/accessing-connectionstrings-from-appconfig-in-a-console-application-project/
published: true
---
<p>Earlier today i added a configuration file to my Console Applicaton Project (Add Item -> Application Configuration File). Via <a href="http://www.google.be/url?sa=t&ct=res&cd=1&url=http%3A%2F%2Fmsdn2.microsoft.com%2Fen-us%2Flibrary%2Fsystem.configuration.configurationsettings.aspx&ei=Z80jRYH_C6emiAKbksTEDA&sig=___7EifcEUZZI1hKTg7xiADzIZfIk=&sig2=l3qMgh7T4zcrtCc2IZOp-A">ConfigurationSettings</a> i could only access the AppSettings. It took me a while to figure out that i had to add a reference to System.Configuration.dll. Once that was done i could access the ConnectionStrings via <a href="http://www.google.be/url?sa=t&ct=res&cd=1&url=http%3A%2F%2Fmsdn2.microsoft.com%2Fen-us%2Flibrary%2Fsystem.configuration.configurationmanager.aspx&ei=wM0jRbOxF7mEiALA4smRDA&sig=__mZt6_vi0x3-IpA4WDtLjmB8J4qU=&sig2=RhtohKiKtaGgUOTNFNtJ-w">ConfigurationManager</a>.</p>