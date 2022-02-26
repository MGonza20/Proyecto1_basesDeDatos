SELECT team_id, (
	SELECT full_name
	FROM team
	WHERE team.id = team_id
), percentile_cont(.5) WITHIN GROUP(ORDER BY three_points_pct) as mediana_three_points
FROM (SELECT 
team_id_home as team_id,
fg3_pct_home as three_points_pct
FROM game
WHERE season_id >= 22020
UNION
SELECT 
team_id_away as team_id,
fg3_pct_away as three_points_pct
FROM game
WHERE season_id >= 22020) stats
GROUP BY team_id
ORDER BY mediana_three_points DESC
LIMIT 10;