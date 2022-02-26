SELECT	team.full_name, asists
FROM	team
JOIN	(SELECT      team_id, SUM(AST) as asists
FROM		player_attributes
WHERE       team_id IN (SELECT team_id_home AS team_id
            FROM game
    		WHERE game.game_date>= '2015-01-01'
    		GROUP BY team_id
)
GROUP BY	team_id
ORDER BY	asists DESC
LIMIT	5) as sub
ON	team.id = sub.team_id
ORDER BY	asists	DESC