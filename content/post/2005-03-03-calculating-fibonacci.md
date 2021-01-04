---
date: "2005-03-03T00:00:00Z"
tags:
- PHP
title: Calculating Fibonacci
aliases:
 - /2005/03/03/calculating-fibonacci/
 - /2005/03/03/calculating-fibonacci.html
---
What is a [recursive](http://en.wikipedia.org/wiki/Recursion) function? It is a function where the value for input n is calculated as a linear combination of the previous 1, 2, ..., n-1 function values. An example is the fibonacci function: f(n) = f(n-1) + f(n-2).

If we program this our first code would look like:

```php
function fibonacci($n)
{
    if ($n < = 1) { return $n; } return fibonacci($n-1) + fibonacci($n-2); 
} 
``` 

It becomes clear that this is really inefficient. For example if we call fibonacci(3) the following function calls will be made:
  
fibonacci(3)
- fibonacci(2)
-- fibonacci(1)
--- fibonacci(0)
--fibonacci(1) 

We can optimize this function by implementing it as an iteration. We still have to calculate all the previous values, thus the time-complexity of this algorithm is O(n). Here is the code:

```php
function fibonacci($n)
{ 
  if ($n < = 1) { return $n; } 
  $nmin2 = 0; 
  $nmin1 = 1; 
  $result = 0; 
  for ($i = 2; $i <= n; ++$i) { 
    $result = $nmin1 + $nmin2; 
    $nmin2 = $nmin1; 
    $nmin1 = $result; 
  }    
  return $result; 
} 
``` 

Time to take our math course and lookup a non-recursive function for fibonacci. Eureka, we have found one! The algorithm has constant time complexity. The proof for this function is can be found [here](http://mathforum.org/library/drmath/view/52686.html).

```php
function fibonacci($n)
{   
  $denominator = pow((1+sqrt(5))/2, $n) -- pow((1-sqrt(5))/2, $n);  
  $nominator = sqrt(5);
  return $denominator / $nominator;
}
```
