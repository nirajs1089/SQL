select stu.name
from Friends
    inner join Packages as p1
    on Friends.ID = p1.ID 
    inner join Packages as p2
    on Friends.Friend_ID = p2.ID
    inner join Students as stu
    on Friends.ID = stu.ID 
    where p2.salary > p1.salary
    order by p2.salary asc;
