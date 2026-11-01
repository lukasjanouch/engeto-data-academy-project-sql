SELECT tljpspf.year, 
		avg(tljpspf.avg_payroll) AS common_yearly_payroll,
		LAG(avg(tljpspf.avg_payroll)) OVER (ORDER BY tljpspf.year) AS previous_year_payroll,
    	((avg(tljpspf.avg_payroll) - LAG(avg(tljpspf.avg_payroll)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.avg_payroll)) OVER (ORDER BY tljpspf.year)) * 100 AS payroll_percentual_difference,
    	avg(tljpspf.avg_price) AS common_yearly_price, 
    	LAG(avg(tljpspf.avg_price)) OVER (ORDER BY tljpspf.year) AS previous_year_price,
    	((avg(tljpspf.avg_price) - LAG(avg(tljpspf.avg_price)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.avg_price)) OVER (ORDER BY tljpspf.year)) * 100 AS price_percentual_difference,
		(((avg(tljpspf.avg_price) - LAG(avg(tljpspf.avg_price)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.avg_price)) OVER (ORDER BY tljpspf.year)) * 100) - 
    	(((avg(tljpspf.avg_payroll) - LAG(avg(tljpspf.avg_payroll)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.avg_payroll)) OVER (ORDER BY tljpspf.year)) * 100) AS inter_annual_growths_difference
    	FROM t_lukas_janouch_project_sql_primary_final AS tljpspf
	WHERE tljpspf.payroll_type LIKE '%mzda%'
	GROUP BY tljpspf.year
	ORDER BY tljpspf.year;