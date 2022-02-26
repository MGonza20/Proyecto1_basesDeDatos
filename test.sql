
-- Hacer una tabla que tenga
-- -> Juegos Ganados Por Equipo 2019
-- -> Juegos Totales Por Equipo 2019
-- -> Poner Temporada

-- Crear ambas tablas
CREATE TABLE teams_summary_2019 (
	team_id INTEGER, 
	played_games INTEGER,
	won_games INTEGER
);
CREATE TABLE teams_summary_2020 (
	team_id INTEGER, 
	played_games INTEGER,
	won_games INTEGER
);

INSERT INTO teams_summary_2019 
(SELECT games_won_home.team_id AS team_id,
(
	SELECT COUNT(*) 
	FROM game
	WHERE (game.team_id_home = games_won_home.team_id OR 
	game.team_id_away = games_won_home.team_id) AND game.season_id = 22019
) AS played_games,
(count_won_home+count_won_away) AS won_games
FROM
(SELECT team_id_home AS team_id, COUNT(*) AS count_won_home
FROM game
WHERE game.season_id = 22019 AND game.pts_home > game.pts_away
GROUP BY team_id
ORDER BY team_id DESC) games_won_home
LEFT JOIN
(SELECT team_id_away AS team_id, COUNT(*) AS count_won_away
FROM game
WHERE game.season_id = 22019 AND game.pts_away > game.pts_home
GROUP BY team_id
ORDER BY team_id DESC) games_won_away ON games_won_home.team_id = games_won_away.team_id
ORDER BY games_won_home.team_id DESC
 );

INSERT INTO teams_summary_2020 
(SELECT games_won_home.team_id AS team_id,
(
	SELECT COUNT(*) 
	FROM game
	WHERE (game.team_id_home = games_won_home.team_id OR 
	game.team_id_away = games_won_home.team_id) AND game.season_id = 22020
) AS played_games,
(count_won_home+count_won_away) AS won_games
FROM
(SELECT team_id_home AS team_id, COUNT(*) AS count_won_home
FROM game
WHERE game.season_id = 22020 AND game.pts_home > game.pts_away
GROUP BY team_id
ORDER BY team_id DESC) games_won_home
LEFT JOIN
(SELECT team_id_away AS team_id, COUNT(*) AS count_won_away
FROM game
WHERE game.season_id = 22020 AND game.pts_away > game.pts_home
GROUP BY team_id
ORDER BY team_id DESC) games_won_away ON games_won_home.team_id = games_won_away.team_id
ORDER BY games_won_home.team_id DESC
 );

-- Respuesta, porcentaje de cambio por equipo
SELECT 
t2019.team_id,
team.full_name,
t2019.played_games AS played_2019,
t2019.won_games AS won_2019,
t2020.played_games AS played_2020,
t2020.won_games AS won_2020,
(
	(t2020.won_games::FLOAT/t2020.played_games::FLOAT) - (t2019.won_games::FLOAT/t2019.played_games::FLOAT)
) / (t2019.won_games::FLOAT/t2019.played_games::FLOAT) AS pct_change
FROM teams_summary_2019 t2019
LEFT JOIN teams_summary_2020 t2020 ON t2020.team_id = t2019.team_id
LEFT JOIN team ON team.id = t2020.team_id
ORDER BY pct_change DESC
LIMIT 5;
