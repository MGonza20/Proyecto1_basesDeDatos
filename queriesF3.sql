-- Guillermo Santos 191517
-- Sara Paguaga 20634

--- Queries - Fase 3


---
-- Respuesta 11 -- Equipos con mas rebounds -- Top 5
---

-- CAMBIO: <game>reb_home a FLOAT
ALTER TABLE game
ALTER COLUMN reb_home TYPE FLOAT USING reb_home::FLOAT
-- CAMBIO: <game>reb_home a FLOAT

-- CAMBIO: <game>reb_away a FLOAT
ALTER TABLE game
ALTER COLUMN reb_away TYPE FLOAT USING reb_away::FLOAT
-- CAMBIO: <game>reb_away a FLOAT 

UPDATE game
SET reb_away ='0'
WHERE reb_away = '';	

UPDATE game
SET reb_home ='0'
WHERE reb_home = '';	

-- Respuesta 11 -- Equipos con mas rebounds -- Top 5
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


--
-- Respuesta 12 -- Equipos con mayores asistencias - Top 5  
--

-- CAMBIO: <player_attributes>ast a FLOAT
ALTER TABLE player_attributes
ALTER COLUMN ast TYPE FLOAT USING ast::FLOAT 
-- CAMBIO: <player_attributes>ast a FLOAT

-- CAMBIO: <team>id a FLOAT
ALTER TABLE team
ALTER COLUMN id TYPE INT USING id::INT
-- CAMBIO: <team>id a FLOAT

-- CAMBIO: <player_attributes>team_id a FLOAT
ALTER TABLE player_attributes
ALTER COLUMN team_id TYPE INT USING team_id::INT
-- CAMBIO: <player_attributes>team_id a FLOAT

UPDATE player_attributes
SET ast ='0'
WHERE ast = '';


-- Seleccionar el id de los equipos y la suma de las asistencias  
SELECT      team_id, SUM(AST) as asists
FROM		player_attributes
WHERE       team_id IN (SELECT team_id_home AS team_id
            FROM game
    		WHERE game.game_date>= '2015-01-01'
    		GROUP BY team_id
)
GROUP BY	team_id
ORDER BY	asists DESC
LIMIT	5;

-- Respuesta 12 - final -- Equipos con mayores asistencias - Top 5  
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


--
-- Respuesta -- Equipos con menos turnovers - Top 5  
--

-- CAMBIO: <game>TEAM_TURNOVERS_AWAY a FLOAT
ALTER TABLE game
ALTER COLUMN team_turnovers_away TYPE FLOAT USING team_turnovers_away::FLOAT
-- CAMBIO: <game>TEAM_TURNOVERS_AWAY a FLOAT

UPDATE game
SET TEAM_TURNOVERS_AWAY ='0'
WHERE TEAM_TURNOVERS_AWAY = '';	

-- Seleccionar ...
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


-- Respuesta 13 -- Equipos con menos turnovers - Top 5 
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

--
-- Respuesta 14 -- Equipos con mas steals -- Top 5
--

-- CAMBIO: <game>stl_home a FLOAT
ALTER TABLE game
ALTER COLUMN stl_home TYPE FLOAT USING stl_home::FLOAT 
-- CAMBIO: <game>stl_home a FLOAT

-- CAMBIO: <game>stl_away a FLOAT
ALTER TABLE game
ALTER COLUMN stl_away TYPE FLOAT USING stl_away::FLOAT 
-- CAMBIO: <game>stl_away a FLOAT


UPDATE game
SET stl_home ='0'
WHERE stl_home = '';	

UPDATE game
SET stl_away ='0'
WHERE stl_away = '';	

-- SELECCIONAR DATA ...
SELECT	team_name_home		AS	team_name,
SUM(stl_home)				AS	steals
FROM						(game
WHERE						game_date >= '2015-01-01'
GROUP BY					team_name
UNION
SELECT	team_name_away		AS	team_name,
SUM(stl_away)				AS	steals
FROM						game
WHERE						game_date >= '2015-01-01'
GROUP BY					team_name
ORDER BY                    steals DESC
LIMIT						5;
							 

-- Respuesta 14 -- Equipos con mas steals -- Top 5
SELECT team_name, SUM(sub.steals) as stealss
FROM (
	SELECT	team_name_home		AS	team_name,
	SUM(stl_home)				AS	steals
	FROM						game
	WHERE						game_date >= '2015-01-01'
	GROUP BY					team_name
	UNION
	SELECT	team_name_away		AS	team_name,
	SUM(stl_away)				AS	steals
	FROM						game
	WHERE						game_date >= '2015-01-01'
	GROUP BY					team_name
	ORDER BY                    steals DESC
) 	AS sub
GROUP BY	team_name
ORDER BY 	stealss	DESC 
LIMIT		5;

