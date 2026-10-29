CREATE OR REPLACE VIEW v_payroll_diference_data AS
	WITH payroll_data AS (
		SELECT DISTINCT tljpspf.payroll_industry_branch,
    		tljpspf.year,
    		tljpspf.avg_payroll,
    		payroll_unit
    	FROM t_lukas_janouch_project_sql_primary_final AS tljpspf
		WHERE tljpspf.payroll_type LIKE '%mzda%'  
		ORDER BY payroll_industry_branch, year
	)
	SELECT
		vpd.payroll_industry_branch,
    	vpd.year,
    	vpd.avg_payroll ,
    	vpd.payroll_unit,
    	LAG(vpd.avg_payroll ) OVER (PARTITION BY vpd.payroll_industry_branch ORDER BY vpd.year) AS previous_year,
    	vpd.avg_payroll - LAG(vpd.avg_payroll) OVER (PARTITION BY vpd.payroll_industry_branch ORDER BY vpd.year) AS difference
	FROM payroll_data AS vpd;	

SELECT vpdd.payroll_industry_branch,
		vpdd.year,
		vpdd.avg_payroll,
		vpdd.payroll_unit,
		vpdd.previous_year,
		vpdd.difference
FROM v_payroll_diference_data AS vpdd
WHERE vpdd.difference < 0; 

SELECT payroll_industry_branch 
FROM t_lukas_janouch_project_sql_primary_final AS tljpspf  
EXCEPT 
SELECT DISTINCT vpdd.payroll_industry_branch
FROM v_payroll_diference_data AS vpdd
WHERE vpdd.difference < 0; 

SELECT DISTINCT
	tljpspf.payroll_industry_branch,
    tljpspf.year,
    tljpspf.avg_payroll ,
    payroll_unit
FROM t_lukas_janouch_project_sql_primary_final AS tljpspf
WHERE tljpspf.payroll_type LIKE '%mzda%'  
AND tljpspf.year IN (
		SELECT min(tljpspf2.year) 
		FROM t_lukas_janouch_project_sql_primary_final AS tljpspf2
		UNION 
		SELECT max(tljpspf2.year) 
		FROM t_lukas_janouch_project_sql_primary_final AS tljpspf2
	)
ORDER BY payroll_industry_branch, year;