/*
    Muestre el top 5 de árbitros en cuyos juegos pitados el equipo visitante pierde.
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre,
COUNT(game) AS numero_juegos
FROM game_officials
LEFT JOIN game ON game_officials.game_id = game.game_id 
AND game.pts_home-game.pts_away>0
AND game.game_date >= '2015-01-01'
GROUP BY official_id, first_name, last_name
ORDER BY numero_juegos DESC
LIMIT 5;