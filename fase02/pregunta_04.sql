/*
    ¿Qué equipo maneja los salarios más altos actualmente?
*/

SELECT nameteam AS nombre_equipo, x2021_22 AS salario
FROM team_salary
ORDER BY x2021_22 DESC
LIMIT 1;