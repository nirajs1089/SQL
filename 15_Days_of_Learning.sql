/*
observations
----- at first level, distinct dates are calculated then looped using select
----- each level is limited by the where clause on date
------ all select clause values are single values
-------col from level 0 is used only for level 2 where clauses not for level 2
-------twice - output of a query is an input to a nested or the same level query
*/
select s1.submission_date,

            (select count(distinct hacker_id)
             from Submissions as s3
             where s3.submission_date = s1.submission_date
             and
             
             (
              (select count(distinct s4.submission_date)   
             from Submissions as s4
            where s4.hacker_id = s3.hacker_id and s4.submission_date < s1.submission_date) = datediff(s1.submission_date,'2016-03-01') 
             )) as every

                                        ,
                    (select s2.hacker_id
                     from Submissions as s2
                     where s2.submission_date = s1.submission_date
                     group by s2.hacker_id
                     order by count(s2.submission_id) desc,s2.hacker_id asc limit 1
                    ) as hid,
                    (select name from Hackers where hacker_id = hid
                    ) as nm
from 
        (select distinct submission_date from Submissions) as s1
order by submission_date

