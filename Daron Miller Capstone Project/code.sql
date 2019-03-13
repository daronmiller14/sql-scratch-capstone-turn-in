--SELECT * FROM survey LIMIT 10;

/*SELECT question,
(SELECT COUNT(DISTINCT user_id)) as 'user count',
100 * COUNT(DISTINCT user_id) /
(SELECT COUNT(DISTINCT user_id) FROM survey) as '%'
	FROM survey
  GROUP BY survey.question; */
  
 --SELECT * FROM quiz LIMIT 5;
 --SELECT * FROM home_try_on LIMIT 5;
 --SELECT * FROM purchase LIMIT 5;
 
  WITH browse AS 
  (SELECT DISTINCT q.user_id,
 	t.user_id IS NOT NULL as 'is_home_try_on',
  t.number_of_pairs = '3 pairs' as 'three_pairs',
	t.number_of_pairs = '5 pairs' as 'five_pairs',
	p.user_id IS NOT NULL as 'is_purchase'
 FROM quiz q LEFT JOIN home_try_on t ON q.user_id = t.user_id LEFT JOIN purchase p ON t.user_id = p.user_id
 )
 SELECT 
-- SUM(three_pairs) as '3_pair',
-- SUM(five_pairs) as '5_pair',
 COUNT(*) as 'num_quizzed',
 SUM(is_home_try_on) as 'num_try_on',
 SUM(is_purchase) as 'num_purchase',
 100.0*SUM(is_home_try_on)/COUNT(user_id) as '% quiz-try_on',
 100.0*SUM(is_purchase)/SUM(is_home_try_on) as '% try_on-purchase'
 	FROM browse;