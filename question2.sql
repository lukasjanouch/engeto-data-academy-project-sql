SELECT tljpspf.year, 
		tljpspf.avg_payroll,
		tljpspf.payroll_type,
		tljpspf.payroll_unit,
		tljpspf.payroll_industry_branch,
		tljpspf.avg_price,
		tljpspf.price_category,
		tljpspf.price_value,
		tljpspf.price_unit,
		floor(tljpspf.avg_payroll / tljpspf.avg_price) AS units_available
FROM t_lukas_janouch_project_sql_primary_final AS tljpspf 
WHERE tljpspf.year IN (
	SELECT min(tljpspf2.year) 
	FROM t_lukas_janouch_project_sql_primary_final AS tljpspf2
	UNION 
	SELECT max(tljpspf2.year) 
	FROM t_lukas_janouch_project_sql_primary_final AS tljpspf2
) AND (lower(tljpspf.price_category) LIKE '%chléb%' OR lower(tljpspf.price_category) LIKE '%mléko%')
AND tljpspf.payroll_type LIKE '%mzda%';