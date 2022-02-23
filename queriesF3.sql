-- Guillermo Santos 191517
-- Sara Paguaga 20634

--- Queries - Fase 3

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


