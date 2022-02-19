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







