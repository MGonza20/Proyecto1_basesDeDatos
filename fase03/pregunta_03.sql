
-- Equipo Con Mas Apariciones en los ALL STAR
SELECT team_id, (
	SELECT full_name
	FROM team
	WHERE team.id = team_id
), SUM(all_star_appearances) AS all_star_appearances
FROM player_attributes
GROUP BY team_id
ORDER BY all_star_appearances DESC;