--left outer join to not avoid empty valued primary keys     
    
select Contests.contest_id,Contests.hacker_id,Contests.name,        
        sum(substats.sum1),sum(substats.sum2),
        sum(stats.sum3),sum(stats.sum4)
        
from Contests

    left outer join Colleges    
    on Contests.contest_id = Colleges.contest_id 
    
    left outer join Challenges     
    on Colleges.college_id = Challenges.college_id
    
    left outer join
    
        (select View_Stats.challenge_id,
         sum(total_views) as sum3,sum(total_unique_views) as sum4
         from View_Stats
         group by View_Stats.challenge_id
        ) as stats
        
    on Challenges.challenge_id = stats.challenge_id
    
        left outer join
        
            (select Submission_Stats.challenge_id,
             sum(total_submissions) as sum1,sum(total_accepted_submissions) as sum2
             from Submission_Stats
             group by Submission_Stats.challenge_id
            ) as substats
            
    on Challenges.challenge_id = substats.challenge_id
    group by Contests.contest_id,Contests.hacker_id,Contests.name
    having (sum(substats.sum1) + sum(substats.sum2) + sum(stats.sum3) + sum(stats.sum4)) > 0
    order by Contests.contest_id;
