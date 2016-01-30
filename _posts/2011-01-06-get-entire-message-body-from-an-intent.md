---
ID: 2036
post_title: Get entire message body from an Intent
author: timvw
post_date: 2011-01-06 20:15:42
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/01/06/get-entire-message-body-from-an-intent/
published: true
dsq_thread_id:
  - "1930548491"
---
<p>I recently started programming the <a href="http://www.android.com/">Android</a> and noticed that most examples for processing an incoming SMS are not entirely correct.</p>

<p>An SMS message is <a href="http://en.wikipedia.org/wiki/SMS#Message_size">limited</a> to 160 characters. Current mobile phones break up a larger message in multiple messages transparently for the user. When Android notifies you about an incoming SMS it has all parts (of that large message) available. So here is how you reconstruct the entire message body from an Intent</p>

[code lang="java"]
Bundle bundle = intent.getExtras();        
if (bundle == null) return;

StringBuilder message = new StringBuilder();
Object[] pdus = (Object[]) bundle.get(&quot;pdus&quot;);

// Rebuild this entire message from the multi part smses/pdus
for (Object pdu : pdus){
 // Notice that i use the deprecated android.telephony.gsm.SmsMessage
 // android.telephony.SmsMessage throws when i call createFromPdu 
 SmsMessage msg = SmsMessage.createFromPdu((byte[])pdu);                
 message.append(msg.getMessageBody().toString());
}
[/code]