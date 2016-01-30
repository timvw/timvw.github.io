---
ID: 1403
post_title: Exploring M-V-VM
author: timvw
post_date: 2009-10-13 16:10:10
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/13/exploring-m-v-vm/
published: true
---
<p>A couple of years ago a collegue recommended <a href="http://www.amazon.com/Data-Binding-Windows-Forms-2-0/dp/032126892X">Data Binding with Windows Forms 2.0: Programming Smart Client Data Applications with .NET</a> and i noticed that my code started to gravitate towards an <a href="http://en.wikipedia.org/wiki/Model_View_ViewModel">Model-View-ViewModel</a> architecture. Due to shortcomings and painful experiences i gave up on databinding and began to use <a href="http://martinfowler.com/eaaDev/PassiveScreen.html">Passieve View</a> instead.</p>

<p>Passive View doesn't work (well) with smart views so i decided to give M-V-VM another because i really wanted to leverage WPF's rich support for databinding.</p>

<p>The key difference between M-V-VM and Passive View is, imho, the fact that the ViewModel is unaware of the View unlike Passive View where the Presenter knows about the (simple) View.</p>

<p>When we test a Presenter i notice that we end up writing interaction based tests (assertions on a mocked view) and when we test a ViewModel we end up writing state-based tests instead.</p>