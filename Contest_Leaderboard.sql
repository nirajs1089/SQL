select temp1.hacker_id,h.name,temp1.Sscore
from 
    (select temp.hacker_id,sum(Mscore) as Sscore
    from (
            select hacker_id,challenge_id,max(score) as Mscore
            from Submissions 
            group by hacker_id,challenge_id
            order by hacker_id,challenge_id asc) as temp
     group by temp.hacker_id
     having Sscore > 0
     order by hacker_id asc) as temp1
inner join Hackers as h
on h.hacker_id = temp1.hacker_id
order by temp1.Sscore desc,temp1.hacker_id asc
