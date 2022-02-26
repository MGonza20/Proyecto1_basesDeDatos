SELECT player_attributes.team_id,
(
	SELECT full_name
	FROM team 
	WHERE team.id = player_attributes.team_id
),
percentile_cont(.70) WITHIN GROUP(ORDER BY (
	ROUND(
	(player_attributes.weight/2.205)/
	(((player_attributes.height)/39.37) * ((player_attributes.height)/39.37))
	,2)
)) as mediana_bmi
FROM player
LEFT JOIN player_attributes ON player_attributes.id = player.id 
WHERE player.is_active = true AND team_id > 0
GROUP BY player_attributes.team_id
ORDER BY mediana_bmi asc
LIMIT 10; 