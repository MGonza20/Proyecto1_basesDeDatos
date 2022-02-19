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


 



