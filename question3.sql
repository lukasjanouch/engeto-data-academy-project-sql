WITH price_data AS (
	SELECT tljpspf.year, 
		tljpspf.avg_price,
		tljpspf.price_category,
		tljpspf.price_value,
		tljpspf.price_unit 
	FROM t_lukas_janouch_project_sql_primary_final AS tljpspf
), price_growth_data as(
	SELECT pd.year,
		pd.avg_price,
		pd.price_category,
		pd.price_value,
		pd.price_unit,
		LAG(pd.avg_price) OVER (PARTITION BY pd.price_category ORDER BY pd.year) AS previous_year,
    	((pd.avg_price - LAG(pd.avg_price) OVER (PARTITION BY pd.price_category ORDER BY pd.year))
    	/ LAG(pd.avg_price) OVER (PARTITION BY pd.price_category ORDER BY pd.year)) * 100 AS percentual_difference
	FROM price_data AS pd
), avg_price_growth_data AS ( 
	SELECT pgd.price_category,
		avg(pgd.percentual_difference) AS avg_percentual_price_growth
	FROM price_growth_data AS pgd
	GROUP BY pgd.price_category
)
SELECT * 
FROM avg_price_growth_data AS apgd
WHERE apgd.avg_percentual_price_growth IN (
	SELECT min(apgd2.avg_percentual_price_growth) 
	FROM avg_price_growth_data AS apgd2
	WHERE apgd2.avg_percentual_price_growth > 0 
); 