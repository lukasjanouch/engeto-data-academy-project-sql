SELECT tljpspf.year, 
		avg(tljpspf.yearly_payroll) AS common_yearly_payroll,
		LAG(avg(tljpspf.yearly_payroll)) OVER (ORDER BY tljpspf.year) AS previous_year_payroll,
    	((avg(tljpspf.yearly_payroll) - LAG(avg(tljpspf.yearly_payroll)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.yearly_payroll)) OVER (ORDER BY tljpspf.year)) * 100 AS payroll_percentual_difference,
    	avg(tljpspf.yearly_price) AS common_yearly_price, 
    	LAG(avg(tljpspf.yearly_price)) OVER (ORDER BY tljpspf.year) AS previous_year_price,
    	((avg(tljpspf.yearly_price) - LAG(avg(tljpspf.yearly_price)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.yearly_price)) OVER (ORDER BY tljpspf.year)) * 100 AS price_percentual_difference,
		(((avg(tljpspf.yearly_price) - LAG(avg(tljpspf.yearly_price)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.yearly_price)) OVER (ORDER BY tljpspf.year)) * 100) - 
    	(((avg(tljpspf.yearly_payroll) - LAG(avg(tljpspf.yearly_payroll)) OVER (ORDER BY tljpspf.year))
    	/ LAG(avg(tljpspf.yearly_payroll)) OVER (ORDER BY tljpspf.year)) * 100) AS inter_annual_growths_difference
    	FROM t_lukas_janouch_project_sql_primary_final AS tljpspf
	GROUP BY tljpspf.year
	ORDER BY tljpspf.year;