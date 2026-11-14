CREATE TABLE t_lukas_janouch_project_SQL_secondary_final AS 
	SELECT e.year,
			e.country,
			e.gdp,
			e.gini,
			e.population
	FROM data_academy_content.countries AS c
	JOIN data_academy_content.economies AS e
	ON c.country = e.country
	WHERE c.continent = 'Europe' AND e.year >= 2006 AND e.year <= 2018 
	GROUP BY e.year, e.country, e.gdp, e.gini, e.population
	ORDER BY e.year, e.gini;

SELECT *,
ROW_NUMBER() OVER (PARTITION BY tljpssf.year ORDER BY tljpssf.gini) AS order
FROM t_lukas_janouch_project_sql_secondary_final AS tljpssf
ORDER BY tljpssf.YEAR, tljpssf.gini;

SELECT avg(tljpssf.gini) AS cz_avg_gini
FROM t_lukas_janouch_project_sql_secondary_final AS tljpssf
WHERE country = 'Czech Republic';

SELECT *,
ROW_NUMBER() OVER (PARTITION BY tljpssf.year ORDER BY tljpssf.gdp DESC) AS order
FROM t_lukas_janouch_project_sql_secondary_final AS tljpssf
ORDER BY tljpssf.YEAR, tljpssf.gdp DESC;

SELECT avg(tljpssf.gdp) AS cz_avg_gdp
FROM t_lukas_janouch_project_sql_secondary_final AS tljpssf
WHERE country = 'Czech Republic';

SELECT avg(tljpssf.gdp) AS cz_avg_gdp
FROM t_lukas_janouch_project_sql_secondary_final AS tljpssf
WHERE country = 'Germany';