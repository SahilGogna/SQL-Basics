/*
- print the hacker_id, name, and the total number of challenges created by each student
- Sort your results by the total number of challenges in descending order
- If more than one student created the same number of challenges, then sort the result by hacker_id
- If more than one student created the same number of challenges 
          and the count is less than the maximum number of challenges created, 
          then exclude those students from the result.
*/

SELECT h.hacker_id, h.name, COUNT(c.hacker_id) as chCount
from Hackers as h 
INNER JOIN Challenges as c 
on  c.hacker_id = h.hacker_id
group by c.hacker_id, h.name
HAVING 
    -- count equal to max of number of challenges created by anyone
    chCount = (
        SELECT MAX(temp1.cnt)
        from (SELECT COUNT(hacker_id) as cnt
             from Challenges
             group by hacker_id
             order by hacker_id) temp1
    )

    OR 
 -- count number of entries that occur just once => total number of submissions are not equal to max and at the same time are unique
    chCount in 
        (select t.cnt
         from (select count(*) as cnt 
               from challenges
               group by hacker_id) t
         group by t.cnt
         having count(t.cnt) = 1)

ORDER by chCount DESC, h.hacker_id
