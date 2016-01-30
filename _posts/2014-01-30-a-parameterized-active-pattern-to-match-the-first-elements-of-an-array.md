---
ID: 2401
post_title: >
  A parameterized active pattern to match
  the first elements of an array
author: timvw
post_date: 2014-01-30 21:16:53
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2014/01/30/a-parameterized-active-pattern-to-match-the-first-elements-of-an-array/
published: true
---
<p>Been writing code in F# for almost a year and never blogged about it. Time to change that ;) Earlier today someone asked the following on twitter:</p>

<quote>Is it possible to pattern match the first part of an array in #FSharp? Something like | 1::2::3::tail but for arrays? #lazyweb</quote>

<p>I accepted the challenge ;)</p>

[code lang="fsharp"]
let (|Array|_|) pattern toMatch =
    let patternLength = Array.length pattern
    let toMatchLength = Array.length toMatch
    let tailLength = toMatchLength - patternLength

    if patternLength &gt; toMatchLength then
        None
    else
        let firstElementsAreEqual = [ 0 .. (patternLength - 1) ] |&gt; Seq.forall (fun i -&gt; pattern.[i] = toMatch.[i])
        if firstElementsAreEqual then
            Some(Array.sub toMatch patternLength tailLength)
        else
            None
        
match [|1;2;3|] with
| Array [|1|] tail -&gt; sprintf &quot;bingo %i&quot; (tail |&gt; Array.sum) // the tail is [|2;3|][/code]

<p>Or as a gist: <a href="https://gist.github.com/timvw/8717796">https://gist.github.com/timvw/8717796</a>.</p>