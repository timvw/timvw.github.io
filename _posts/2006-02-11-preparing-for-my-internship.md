---
ID: 57
post_title: Preparing for my internship
author: timvw
post_date: 2006-02-11 21:26:22
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/02/11/preparing-for-my-internship/
published: true
---
<p>Only two more days before my internship starts. I'm a bit nervous and excited to dive into this adventure. Today i decided to fresh my knowledge of (MS)-C++ a bit up. I've read a tutorial on <a href="http://www.newty.de/fpt/index.html">function pointers</a> and <a href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/vccore98/html/_core_argument_passing_and_naming_conventions.asp">naming conventions</a>. A couple of weeks ago i already had a look at <a href="http://linuxquality.sunsite.dk/articles/memberpointers/">pointers to member functions</a>.</p>
[code lang="cpp"]
#include <iostream>
using namespace std;

void customcallback() {
        cout << "running custom callback" << endl;
}

typedef int (*method)(int, int);

int sum(int a, int b) {
        return a + b;
}

method dosum() {
        return &sum;
}

int main() {
        void (*plugin)() = NULL;
        plugin = &customcallback;
        plugin();

        method mymethod = dosum();
        cout << mymethod(10, 4) << endl;

        return 0;
}
[/code]