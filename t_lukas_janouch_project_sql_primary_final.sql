CREATE TABLE t_lukas_janouch_project_SQL_primary_final AS 
	SELECT avg(cpa.value) AS yearly_payroll,
			cpu."name" AS payroll_unit,
			cpib."name" AS payroll_industry_branch,
			cpa.payroll_year AS year, 
			avg(cpr.value) AS yearly_price,
			cpc2."name" AS price_category,
			cpc2.price_value,
			cpc2.price_unit
	FROM data_academy_content.czechia_payroll AS cpa
	JOIN data_academy_content.czechia_price AS cpr
	ON cpa.payroll_year = date_part('year', cpr.date_from)
	JOIN data_academy_content.czechia_payroll_value_type AS cpvt 
	ON cpa.value_type_code = cpvt.code
	JOIN data_academy_content.czechia_payroll_unit AS cpu 
	ON cpa.unit_code = cpu.code 
	JOIN data_academy_content.czechia_payroll_calculation AS cpc 
	ON cpa.calculation_code = cpc.code 
	JOIN data_academy_content.czechia_payroll_industry_branch AS cpib 
	ON cpa.industry_branch_code = cpib.code
	JOIN data_academy_content.czechia_price_category AS cpc2 
	ON cpr.category_code = cpc2.code 
	JOIN data_academy_content.czechia_region AS cr 
	ON cpr.region_code = cr.code
	WHERE cpc.name = 'přepočtený' AND cpvt.name LIKE '%mzda%' 
	GROUP BY year, payroll_unit, payroll_industry_branch, price_category, price_unit, price_value;