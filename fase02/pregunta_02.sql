/*
    ¿Cuál fue el promedio de puntos anotados y recibidos por cada equipo en cada una de las temporadas relevantes?
*/

SELECT 
team_name, 
avg(p.promedio_puntos_anotados) FILTER (WHERE p.season_id = 22015) AS avg_anotados_2015, 
avg(p.promedio_puntos_recibidos) FILTER (WHERE p.season_id = 22015) AS avg_recibidos_2015,
avg(p.promedio_puntos_anotados) FILTER (WHERE p.season_id = 22016) AS avg_anotados_2016, 
avg(p.promedio_puntos_recibidos) FILTER (WHERE p.season_id = 22016) AS avg_recibidos_2016,
avg(p.promedio_puntos_anotados) FILTER (WHERE p.season_id = 22017) AS avg_anotados_2017, 
avg(p.promedio_puntos_recibidos) FILTER (WHERE p.season_id = 22017) AS avg_recibidos_2017,
avg(p.promedio_puntos_anotados) FILTER (WHERE p.season_id = 22018) AS avg_anotados_2018, 
avg(p.promedio_puntos_recibidos) FILTER (WHERE p.season_id = 22018) AS avg_recibidos_2018,
avg(p.promedio_puntos_anotados) FILTER (WHERE p.season_id = 22019) AS avg_anotados_2019, 
avg(p.promedio_puntos_recibidos) FILTER (WHERE p.season_id = 22019) AS avg_recibidos_2019,
avg(p.promedio_puntos_anotados) FILTER (WHERE p.season_id = 22020) AS avg_anotados_2020, 
avg(p.promedio_puntos_recibidos) FILTER (WHERE p.season_id = 22020) AS avg_recibidos_2020
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
GROUP BY team_name
ORDER BY (team_name) ASC;