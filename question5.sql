WITH payroll_price_growth_data AS (
	SELECT tljpspf.year, 
		avg(tljpspf.avg_payroll) AS common_yearly_payroll,
		LAG(avg(tljpspf.avg_payroll)) OVER (ORDER BY tljpspf.year) AS previous_year_payroll,
    	((avg(tljpspf.avg_payroll) - LAG(avg(tljpspf.avg_payroll)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.avg_payroll)) OVER (ORDER BY tljpspf.year)) * 100 AS payroll_percentual_difference,
    	avg(tljpspf.avg_price) AS common_yearly_price, 
    	LAG(avg(tljpspf.avg_price)) OVER (ORDER BY tljpspf.year) AS previous_year_price,
    	((avg(tljpspf.avg_price) - LAG(avg(tljpspf.avg_price)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.avg_price)) OVER (ORDER BY tljpspf.year)) * 100 AS price_percentual_difference
		FROM t_lukas_janouch_project_sql_primary_final AS tljpspf
	WHERE tljpspf.payroll_type LIKE '%mzda%'
	GROUP BY tljpspf.year
	ORDER BY tljpspf.year
)
SELECT e.year,
		/*e.gdp,
		LAG(e.gdp) OVER (ORDER BY e.year) AS previous_year_payroll,*/
		((e.gdp - LAG(e.gdp) OVER (ORDER BY e.year))
    	/ LAG(e.gdp) OVER (ORDER BY e.year)) * 100 AS gdp_percentual_difference,
		/*ppgd.common_yearly_payroll, 
		ppgd.previous_year_payroll,*/
		ppgd.payroll_percentual_difference,
		/*ppgd.common_yearly_price,
		ppgd.previous_year_price,*/
		ppgd.price_percentual_difference 
FROM payroll_price_growth_data ppgd
JOIN data_academy_content.economies e
ON ppgd.year = e."year"
WHERE country = 'Czech Republic'; 