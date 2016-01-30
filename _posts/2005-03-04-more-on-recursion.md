---
ID: 95
post_title: More on recursion
author: timvw
post_date: 2005-03-04 01:34:26
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/03/04/more-on-recursion/
published: true
---
<p>Yesterday i already wrote that an interative implementation for a recursive function is more efficient. And i gave you an example of the fibonacci function. Well, today i'm here to present you an implementation for every recursive function.</p>
[code lang="php"]class Math
{
    // calculate the linear combination
    // fe:
    // coefficients = array(1, 2, 3)
    // values = array(4, 5, 6)
    // returns:  (1 * 4) + (2 * 5) + (3 * 6)
    function lc($coefficients, $values)
    {
        if (count($coefficients) != count($values))
        {
            return false;
        }

        $result = 0;
        for ($i = 0; $i &lt; count($coefficients); ++$i)
        {
            $result += $coefficients[$i] * $values[$i];
        }
        return $result;
    }

    // lookup the value for the recursive function
    // fe:
    // n: 3
    // coefficients = array(a, b)
    // initvalues = array(0, 1)
    // returns: 2
    // this is the same as f(n) = (a * (n-2)) + (b * (n-1))
    function recursive($n, $coefficients, $initvalues)
    {
        if ($n &lt; count($initvalues))
        {
            return $initvalues[$n];
        }

        for ($i = count($initvalues); $i &lt;= $n; ++$i)
        {
            $result = Math::lc($coefficients, $initvalues);
            array_shift($initvalues);
            array_push($initvalues, $result);
        }
        return $result;
    }
}
[/code]
<p>As an example we use this class to calculate fibonacci(3):</p>
[code lang="php"]$coefficients = array(1, 1); // f(n) = (1 * f(n-2)) + (1 * f(n-1))
$initvalues = array(0, 1); // f(0) = 0 and f(1) = 1
echo Math::recursive(3, $coefficients, $initvalues);
[/code]