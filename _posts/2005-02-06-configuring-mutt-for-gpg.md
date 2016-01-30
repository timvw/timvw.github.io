---
ID: 98
post_title: Configuring Mutt for GPG
author: timvw
post_date: 2005-02-06 01:43:10
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/02/06/configuring-mutt-for-gpg/
published: true
dsq_thread_id:
  - "1926368390"
---
<p>Today i generated a <a href="http://www.pgpi.org/">PGP</a> (Pretty Good Privacy) key for my e-mail address. I also configured my mailclient, <a href="http://www.mutt.org">mutt</a>, for use with <a href="http://www.gnupg.org">GnuPG</a>. I copied a sample file i found on the net but always got an error message: sh: line 1: pgpewrap: command not found. It appears that /usr/lib/mutt/ is not in the path and therefore is not found. Here is the tweaked .muttrc part:</p>
<pre>
set pgp_decode_command=&quot;gpg %?p?--passphrase-fd 0? --no-verbose --batch --output - %f&quot;
set pgp_verify_command=&quot;gpg --no-verbose --batch --output - --verify %s %f&quot;
set pgp_decrypt_command=&quot;gpg --passphrase-fd 0 --no-verbose --batch --output - %f&quot;
set pgp_sign_command=&quot;gpg --no-verbose --batch --output - --passphrase-fd 0 --armor --detach-sign \
--textmode %?a?-u %a? %f&quot;
set pgp_clearsign_command=&quot;gpg --no-verbose --batch --output - --passphrase-fd 0 --armor \
--textmode --clearsign %?a?-u %a? %f&quot;
set pgp_encrypt_only_command=&quot;/usr/lib/mutt/pgpewrap gpg --batch --quiet --no-verbose --output - --encrypt \
--textmode --armor --always-trust --encrypt-to 0xE38BE821 -- -r %r -- %f&quot;
set pgp_encrypt_sign_command=&quot;/usr/lib/mutt/pgpewrap gpg --passphrase-fd 0 --batch --quiet --no-verbose \
--textmode --output - --encrypt --sign %?a?-u %a? --armor --always-trust --encrypt-to 0xE38BE821 -- -r %r -- %f&quot;
set pgp_import_command=&quot;gpg --no-verbose --import -v %f&quot;
set pgp_export_command=&quot;gpg --no-verbose --export --armor %r&quot;
set pgp_verify_key_command=&quot;gpg --no-verbose --batch --fingerprint --check-sigs %r&quot;
set pgp_list_pubring_command=&quot;gpg --no-verbose --batch --with-colons --list-keys %r&quot;
set pgp_list_secring_command=&quot;gpg --no-verbose --batch --with-colons --list-secret-keys %r&quot;
set pgp_autosign=no
set pgp_sign_as=0xE38BE821
set pgp_replyencrypt=yes
set pgp_timeout=1800
set pgp_good_sign=&quot;^gpg: Good signature from&quot;
</pre>