---
date: 2024-07-01
title: Upgrading microk8s (snap) on Ubuntu
---
I have been using [microk8s](https://microk8s.io/) for a couple of years now.
On my ubuntu system it's installed as a [snap](https://snapcraft.io/) and was stuck on v1.28.
I was greeted with an error something similar to: 

```text
Hit:2 http://security.ubuntu.com/ubuntu jammy-security InRelease
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8,993 B]
Err:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05
...
```

Here is how you can fix this:

```bash
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

```bash
sudo apt update
sudo apt-get upgrade
sudo snap refresh microk8s --channel=1.29/stable
```

Or more recent version:

```bash
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt-get upgrade

sudo snap refresh microk8s --channel=1.30/stable
```

There you go :)


