---
date: "2011-01-06T00:00:00Z"
guid: http://www.timvw.be/?p=2036
tags:
- Android
- Java
title: Get entire message body from an Intent
---
I recently started programming the [Android](http://www.android.com/) and noticed that most examples for processing an incoming SMS are not entirely correct.

An SMS message is [limited](http://en.wikipedia.org/wiki/SMS#Message_size) to 160 characters. Current mobile phones break up a larger message in multiple messages transparently for the user. When Android notifies you about an incoming SMS it has all parts (of that large message) available. So here is how you reconstruct the entire message body from an Intent

```java
Bundle bundle = intent.getExtras();
if (bundle == null) return;

StringBuilder message = new StringBuilder();  
Object[] pdus = (Object[]) bundle.get("pdus");

// Rebuild this entire message from the multi part smses/pdus  
for (Object pdu : pdus){
  // Notice that i use the deprecated android.telephony.gsm.SmsMessage
  // android.telephony.SmsMessage throws when i call createFromPdu
  SmsMessage msg = SmsMessage.createFromPdu((byte[])pdu);
  message.append(msg.getMessageBody().toString());  
}  
```
