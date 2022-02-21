-- Sara Paguaga 20634
-- Guillermo Santos 191517
 
-- Pregunta 01

-- CAMBIO: <player_attributes>height a FLOAT
UPDATE player_attributes
SET height ='0'
WHERE height = '';
ALTER TABLE player_attributes
ALTER COLUMN height TYPE NUMERIC USING height::NUMERIC;
-- CAMBIO: <player_attributes>height a FLOAT


-- CAMBIO: <player_attributes>weight a FLOAT
UPDATE player_attributes
SET weight ='0'
WHERE weight = '';
ALTER TABLE player_attributes
ALTER COLUMN weight TYPE NUMERIC USING weight::NUMERIC;
-- CAMBIO: <player_attributes>height a FLOAT

-- CAMBIO: <player>is_active a BOOLEAN
ALTER TABLE player
ALTER COLUMN is_active TYPE BOOLEAN USING is_active::BOOLEAN;
-- CAMBIO: <player>is_active a BOOLEAN

-- CAMBIO: <player>id a INT
ALTER TABLE player
ALTER COLUMN id TYPE INT USING id::INT;
-- CAMBIO: <player>id a INT

-- CAMBIO: <player_attributes>id a INT
ALTER TABLE player_attributes
ALTER COLUMN id TYPE INT USING id::INT;
-- CAMBIO: <player_attributes>id a INT

-- Respuesta A
SELECT display_first_last AS nombre_apellido, 
ROUND((player_attributes.height)/39.37,2) AS altura_metros
FROM player
LEFT JOIN player_attributes ON player_attributes.id = player.id 
WHERE player.is_active = true
ORDER BY player_attributes.height DESC
LIMIT 1;

-- Respuesta B
SELECT display_first_last AS nombre_apellido, 
ROUND((player_attributes.height)/39.37,2) AS altura_metros
FROM player
LEFT JOIN player_attributes ON player_attributes.id = player.id 
WHERE player.is_active = true
ORDER BY player_attributes.height ASC
LIMIT 1;

-- Pregunta 02
-- Promedio de puntos anotados y recibidos por cada equipo

-- Paso 1 -> Filtrar juegos con fecha mayora 2015/01/01
SELECT    *
FROM	game
WHERE	game_date >= '2015-01-01';

SELECT      season_id, team_name_home, COUNT(*)
FROM        game
WHERE       game_date >= '2015-01-01'
GROUP BY    season_id, team_name_home
ORDER BY team_name_home DESC;

-- Paso 2 -> Obtener promedio de puntos cuando son home
SELECT      season_id, team_name_home, 
AVG(pts_home) AS promedio_puntos_anotados,
AVG(pts_away) AS promedio_puntos_recibidos
FROM        game
WHERE       game_date >= '2015-01-01'
GROUP BY    season_id, team_name_home
ORDER BY team_name_home DESC;

-- Paso 2 -> Obtener promedio de puntos cuando son away
SELECT      season_id, team_name_away, 
AVG(pts_away) AS promedio_puntos_anotados,
AVG(pts_home) AS promedio_puntos_recibidos
FROM        game
WHERE       game_date >= '2015-01-01'
GROUP BY    season_id, team_name_away
ORDER BY team_name_away DESC;

-- Paso 3 -> Unir ambas queries
SELECT 
season_id,
team_name, 
avg(p.promedio_puntos_anotados) AS promedio_puntos_anotados, 
avg(p.promedio_puntos_recibidos) AS promedio_puntos_recibidos
FROM (
	SELECT      season_id, team_name_home AS team_name, 
	AVG(pts_home) AS promedio_puntos_anotados,
	AVG(pts_away) AS promedio_puntos_recibidos
	FROM        game
	WHERE       game_date >= '2015-01-01'
	GROUP BY    season_id, team_name
	UNION
	SELECT      season_id, team_name_away AS team_name, 
	AVG(pts_away) AS promedio_puntos_anotados,
	AVG(pts_home) AS promedio_puntos_recibidos
	FROM        game
	WHERE       game_date >= '2015-01-01'
	GROUP BY    season_id, team_name
) AS p
GROUP BY season_id, team_name
ORDER BY (team_name,season_id) ASC;


-- Pregunta 03
-- CAMBIO: <game_officials>official_id a INT
ALTER TABLE game_officials
ALTER COLUMN official_id TYPE INT USING official_id::INT;
-- CAMBIO: <game_officials>official_id a INT

-- CAMBIO: <game_officials>game_id a INT
ALTER TABLE game_officials
ALTER COLUMN game_id TYPE INT USING game_id::INT;
-- CAMBIO: <game_officials>game_id a INT

-- CAMBIO: <game>pts_home a INT
ALTER TABLE game
ALTER COLUMN pts_home TYPE INT USING pts_home::INT,
ALTER COLUMN pts_away TYPE INT USING pts_away::INT;
-- CAMBIO: <game>pts_home a INT
-- Parte 01, traer los partidos donde haya perdido el visitante
SELECT COUNT(*)
FROM game
WHERE pts_home-pts_away > 0
-- Parte 02, agrupar los game officials por id y mostrar sus nombres
SELECT CONCAT(first_name, ' ', last_name) AS nombre
FROM game_officials
GROUP BY official_id, first_name, last_name;
-- Respuesta
SELECT official_id, CONCAT(first_name, ' ', last_name) AS nombre,
COUNT(game) AS numero_juegos
FROM game_officials
LEFT JOIN game ON game_officials.game_id = game.game_id 
AND game.pts_home-game.pts_away>0
GROUP BY official_id, first_name, last_name
ORDER BY numero_juegos DESC
LIMIT 5;

-- Pregunta 05 B
-- Parte 1 -> Obtener todas las temporadas
SELECT season_id FROM game
GROUP BY season_id
ORDER BY season_id DESC;
-- Parte 2 -> Obtener el prolongamiento de partidos por cada temporada
SELECT '2011-12-31 01:00:00'::timestamp - '2011-12-29 23:00:00'::timestamp;

SELECT game_date 
	FROM game g2
	WHERE g2.season_id = 22020
	ORDER BY game_date DESC
	LIMIT 1;

SELECT season_id,
(
	SELECT MAX(game_date) 
	FROM game g2
	WHERE g2.season_id = game.season_id
) -
(
	SELECT MIN(game_date)
	FROM game g2
	WHERE g2.season_id = game.season_id
) AS diferencia_fecha
FROM game
GROUP BY season_id
ORDER BY diferencia_fecha DESC
LIMIT 3;

-- Pregunta 05
SELECT season_id, COUNT(*) AS cant_partidos
FROM game
GROUP BY season_id
ORDER BY cant_partidos DESC
LIMIT 1;

-- Pregunta 06
-- CAMBIO: <game>team_id_home a INT
ALTER TABLE game
ALTER COLUMN team_id_home TYPE INT USING team_id_home::INT,
ALTER COLUMN team_id_away TYPE INT USING team_id_away::INT;
-- CAMBIO: <game>pts_home a INT
-- Obtener la diferencia a favor en juegos por equipo cuando es home

SELECT 
team_id_home AS team_id,
team_name_home AS team_name, 
AVG(game.pts_home-game.pts_away) AS diferencia
FROM game
GROUP BY team_id, team_name
ORDER BY team_id DESC;

-- Obtener la diferencia cuando el equipo es visitante
SELECT 
team_id_away AS team_id,
team_name_away AS team_name, 
AVG(game.pts_away-game.pts_home) AS diferencia
FROM game
GROUP BY team_id, team_name
ORDER BY team_id DESC;

-- Combinar ambas queries
-- SEASON ID 2017
-- SEASON ID 2018
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
-- Pregunta 07

SELECT ps.nameplayer, ps.value
FROM draft AS d
INNER JOIN player_salary AS ps
ON d.nameplayer = ps.nameplayer
WHERE yeardraft = '2018.0' AND slugseason = '2021-22'
ORDER BY ps.value DESC
LIMIT 1;


-- Pregunta 08
-- CAMBIO: <team_salary>X2020-21 a FLOAT
ALTER TABLE team_salary
ALTER COLUMN "x2020_21" TYPE INT USING x2020_21::FLOAT,
ALTER COLUMN "x2021_22" TYPE INT USING x2021_22::FLOAT;
-- CAMBIO: <team_salary>X2021-22 a FLOAT

-- Obtener el numero de equipos por estoad
SELECT state, COUNT(*)
FROM team
GROUP BY state;


-- Filtrar la tabla estado y hacer una sub query del salario
SELECT state, (
	SELECT SUM(x2020_21)
	FROM team_salary
	WHERE team_salary.slugTeam IN (
		SELECT abbreviation
		FROM team t
		WHERE t.state = team.state
	)
) as salaries
FROM team
GROUP BY state
ORDER BY salaries DESC
LIMIT 5;

SELECT state, (
	SELECT SUM(x2021_22)
	FROM team_salary
	WHERE team_salary.slugTeam IN (
		SELECT abbreviation
		FROM team t
		WHERE t.state = team.state
	)
) as salaries
FROM team
GROUP BY state
ORDER BY salaries DESC
LIMIT 5;

