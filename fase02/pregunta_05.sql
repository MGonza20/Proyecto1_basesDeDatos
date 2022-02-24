/* 
    ¿Cuál fue la temporada con más partidos en la historia de la NBA? ¿Cuál fue la temporada
    que más se ha prolongado en fechas?
*/

-- Temporada con mas partidos
SELECT season_id, COUNT(*) AS cant_partidos
FROM game
GROUP BY season_id
ORDER BY cant_partidos DESC
LIMIT 1;
-- Temporada que se prolongo mas
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
LIMIT 1;