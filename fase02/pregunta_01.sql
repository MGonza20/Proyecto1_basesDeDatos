/* 
   ¿Quién es el jugador activo más alto? ¿Y el más bajo? 
*/

-- El jugador mas alto
SELECT display_first_last AS nombre_apellido, 
ROUND((player_attributes.height)/39.37,2) AS altura_metros
FROM player
LEFT JOIN player_attributes ON player_attributes.id = player.id 
WHERE player.is_active = true
ORDER BY player_attributes.height DESC
LIMIT 1;
-- Tacko Fall -> 2.26m

-- El jugador mas bajo
SELECT display_first_last AS nombre_apellido, 
ROUND((player_attributes.height)/39.37,2) AS altura_metros
FROM player
LEFT JOIN player_attributes ON player_attributes.id = player.id 
WHERE player.is_active = true
ORDER BY player_attributes.height ASC
LIMIT 1;
-- Isaiah Thomas -> 1.75m

