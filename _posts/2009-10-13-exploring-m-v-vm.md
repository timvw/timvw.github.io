---
id: 1403
title: Exploring M-V-VM
date: 2009-10-13T16:10:10+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1403
permalink: /2009/10/13/exploring-m-v-vm/
tags:
  - Patterns
  - Silverlight
  - WPF
---
A couple of years ago a collegue recommended [Data Binding with Windows Forms 2.0: Programming Smart Client Data Applications with .NET](http://www.amazon.com/Data-Binding-Windows-Forms-2-0/dp/032126892X) and i noticed that my code started to gravitate towards an [Model-View-ViewModel](http://en.wikipedia.org/wiki/Model_View_ViewModel) architecture. Due to shortcomings and painful experiences i gave up on databinding and began to use [Passieve View](http://martinfowler.com/eaaDev/PassiveScreen.html) instead.

Passive View doesn't work (well) with smart views so i decided to give M-V-VM another because i really wanted to leverage WPF's rich support for databinding.

The key difference between M-V-VM and Passive View is, imho, the fact that the ViewModel is unaware of the View unlike Passive View where the Presenter knows about the (simple) View.

When we test a Presenter i notice that we end up writing interaction based tests (assertions on a mocked view) and when we test a ViewModel we end up writing state-based tests instead.
