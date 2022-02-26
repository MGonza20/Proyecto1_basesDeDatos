SELECT	team_name,
SUM(sub.total_turnovers) as total_TO
FROM(
	SELECT	team_name_home		AS	team_name,
	SUM(TEAM_TURNOVERS_AWAY)	AS	total_turnovers
	FROM						game
	WHERE						game_date >= '2015-01-01'
	GROUP BY					team_name
	UNION
	SELECT	team_name_away		AS	team_name,
	SUM(TEAM_TURNOVERS_AWAY)	AS	total_turnovers
	FROM						game
	WHERE						game_date >= '2015-01-01'
	GROUP BY					team_name
	ORDER BY                    total_turnovers ASC
) AS sub
GROUP BY team_name
ORDER BY total_TO ASC
LIMIT 5;