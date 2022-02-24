/*
    ¿Cuál es el jugador más valioso del draft del 2018?
*/

SELECT		ps.nameplayer, ps.value
FROM		draft AS d
INNER JOIN	player_salary AS ps
ON			d.nameplayer = ps.nameplayer
WHERE		yeardraft = '2018.0'	AND	slugseason = '2021-22'
ORDER BY	ps.value DESC
LIMIT		1;