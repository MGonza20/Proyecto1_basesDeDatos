SELECT team_name, SUM(sub.rebounds) as team_rebounds
FROM (
	SELECT	team_name_home		AS	team_name,
	SUM(reb_home)				AS	rebounds
	FROM						game
	WHERE						game_date >= '2015-01-01'
	GROUP BY					team_name
	UNION
	SELECT	team_name_away		AS	team_name,
	SUM(reb_away)				AS	rebounds
	FROM						game
	WHERE						game_date >= '2015-01-01'
	GROUP BY					team_name
	ORDER BY                    rebounds DESC
) 	AS sub
GROUP BY	team_name
ORDER BY 	team_rebounds	DESC 
LIMIT		5;