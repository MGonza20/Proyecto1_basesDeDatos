/*
    Calcule el top 5 de los estados que más salarios pagaron durante las temporadas
    2020/2021 y 2021/2022.
*/
--2020/2021
SELECT state, (
	SELECT SUM(x2020_21)
	FROM team_salary
	WHERE team_salary.slugTeam IN (
		SELECT abbreviation
		FROM team t
		WHERE t.state = team.state
	)
) as salaries
FROM team
GROUP BY state
HAVING (
	SELECT SUM(x2020_21)
	FROM team_salary
	WHERE team_salary.slugTeam IN (
		SELECT abbreviation
		FROM team t
		WHERE t.state = team.state
	)
) > 0
ORDER BY salaries DESC
LIMIT 5;
--2021/2022
SELECT state, (
	SELECT SUM(x2021_22)
	FROM team_salary
	WHERE team_salary.slugTeam IN (
		SELECT abbreviation
		FROM team t
		WHERE t.state = team.state
	)
) as salaries
FROM team
GROUP BY state
HAVING (
	SELECT SUM(x2021_22)
	FROM team_salary
	WHERE team_salary.slugTeam IN (
		SELECT abbreviation
		FROM team t
		WHERE t.state = team.state
	)
) > 0
ORDER BY salaries DESC
LIMIT 5;