SELECT team_name, SUM(sub.steals) as stealss
FROM (
	SELECT	team_name_home		AS	team_name,
	SUM(stl_home)				AS	steals
	FROM						game
	WHERE						game_date >= '2020-01-01'
	GROUP BY					team_name
	UNION
	SELECT	team_name_away		AS	team_name,
	SUM(stl_away)				AS	steals
	FROM						game
	WHERE						game_date >= '2020-01-01'
	GROUP BY					team_name
	ORDER BY                    steals DESC
) 	AS sub
GROUP BY	team_name
ORDER BY 	stealss	DESC 
LIMIT		5;