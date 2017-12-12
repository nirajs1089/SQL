/*You are given a table, Functions, containing two columns: X and Y.



Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X.*/

-- addition and multiplication for a pair of numbers creates a unique combination to that pair in either order.

select min(x),max(y)
from Functions
group by (x+y),(x*y)
having count(x) > 1
order by (x+y),(x*y);
