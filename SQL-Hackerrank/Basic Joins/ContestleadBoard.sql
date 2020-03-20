/*
The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
Exclude all hackers with a total score of  from your result.
*/

SELECT h.hacker_id, h.name, SUM(score) as total_score
FROM Hackers h 
INNER JOIN (
    SELECT hacker_id , max(score) as score from Submissions GROUP BY challenge_id, hacker_id
) max_score
on h.hacker_id = max_score.hacker_id
GROUP BY h.hacker_id, name 
HAVING total_score > 0
order by total_score desc, h.hacker_id;