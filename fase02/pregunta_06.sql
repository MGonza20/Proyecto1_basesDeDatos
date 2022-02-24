/*
¿Cuál es el equipo que más diferencia de puntos a favor obtuvo en promedio por partido
para la temporada 2017? ¿Y para la temporada 2018?
*/

-- 2017
SELECT 
team_name,
AVG(diferencia) as avg_diferencia
FROM(
SELECT 
team_id_home AS team_id,
team_name_home AS team_name, 
AVG(game.pts_home-game.pts_away) AS diferencia
FROM game
WHERE game.season_id = 22017
GROUP BY team_id, team_name
UNION
SELECT 
team_id_away AS team_id,
team_name_away AS team_name, 
AVG(game.pts_away-game.pts_home) AS diferencia
FROM game
WHERE game.season_id = 22017
GROUP BY team_id, team_name
ORDER BY team_name DESC
) team
GROUP BY team.team_id, team.team_name
ORDER BY avg_diferencia DESC
LIMIT 1;

--2018
SELECT 
team_name,
AVG(diferencia) as avg_diferencia
FROM(
SELECT 
team_id_home AS team_id,
team_name_home AS team_name, 
AVG(game.pts_home-game.pts_away) AS diferencia
FROM game
WHERE game.season_id = 22018
GROUP BY team_id, team_name
UNION
SELECT 
team_id_away AS team_id,
team_name_away AS team_name, 
AVG(game.pts_away-game.pts_home) AS diferencia
FROM game
WHERE game.season_id = 22018
GROUP BY team_id, team_name
ORDER BY team_name DESC
) team
GROUP BY team.team_id, team.team_name
ORDER BY avg_diferencia DESC
LIMIT 1;

