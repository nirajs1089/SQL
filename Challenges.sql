
set @max = (select max(cntChg)
            from 
            (select Challenges.hacker_id,Hackers.name,count(challenge_id) as cntChg
                    from Hackers 
                    inner join Challenges
                    on Hackers.hacker_id = Challenges.hacker_id
                    group by hacker_id,name
                    order by cntChg desc,Challenges.hacker_id asc) as temp3);


select temp3.hacker_id,temp3.name,temp3.cntChg
from 
        (select Challenges.hacker_id,Hackers.name,count(challenge_id) as cntChg
                from Hackers 
                inner join Challenges
                on Hackers.hacker_id = Challenges.hacker_id
                group by hacker_id,name
                order by cntChg desc,Challenges.hacker_id asc) 
                as temp3

        inner join 

# testing
        (select cntChg as chlg,count(cntChg) as times
        from (
                select Challenges.hacker_id,Hackers.name,count(challenge_id) as cntChg
                from Hackers 
                inner join Challenges
                on Hackers.hacker_id = Challenges.hacker_id
                group by hacker_id,name
                order by cntChg desc,Challenges.hacker_id asc) 
         as temp
        group by cntChg
        having times > 0
        order by times desc) 
        as temp2

on temp3.cntChg = temp2.chlg
where temp2.times = 1 or (temp2.times > 1 and temp3.cntChg >= @max)
order by temp3.cntChg desc, temp3.hacker_id asc
 
