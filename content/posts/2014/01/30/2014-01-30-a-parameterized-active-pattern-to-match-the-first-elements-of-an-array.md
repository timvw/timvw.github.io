---
date: "2014-01-30T00:00:00Z"
guid: http://www.timvw.be/?p=2401
tags:
- Active Pattern
- FSharp
- Pattern Matching
title: A parameterized active pattern to match the first elements of an array
---
Been writing code in F# for almost a year and never blogged about it. Time to change that. Earlier today someone asked the following on twitter:

<quote>Is it possible to pattern match the first part of an array in #FSharp? Something like | 1::2::3::tail but for arrays? #lazyweb</quote>

I accepted the challenge :)

```fsharp
let (|Array|_|) pattern toMatch =      
	let patternLength = Array.length pattern
	let toMatchLength = Array.length toMatch
	let tailLength = toMatchLength - patternLength

	if patternLength > toMatchLength then
		None
	else
		let firstElementsAreEqual = [ 0 .. (patternLength - 1) ] |> Seq.forall (fun i -> pattern.[i] = toMatch.[i])
          
		if firstElementsAreEqual then
			Some(Array.sub toMatch patternLength tailLength)
		else 
			None
		
match [|1;2;3|] with
| Array \[|1|] tail -> sprintf "bingo %i" (tail |> Array.sum) // the tail is [|2;3|\]
```

Or as a gist: <https://gist.github.com/timvw/8717796>.