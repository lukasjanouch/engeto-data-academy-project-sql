# Projekt z SQL 

## Cíl 

Cílem projektu bylo odpovědět na otázky, které se týkaly dostupnosti základních
potravin pro širokou veřejnost, jako kdybychom pracovali pro organizaci
zabývající se životní úrovní občanů. Hlavní úkol spočíval v porovnání
dostupnosti potravin na základě průměrných příjmů za určité časové období.

Projekt navíc obsahuje i data o dalších evropských státech ve stejném období
jako primární přehled pro ČR.

## Výzkumné otázky 

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

> Základ selectů vracejících odpovědi na tuto otázku tvoří pohled
v_payroll_diference_data. Oproti Common table expressionu je u pohledu výhoda,
že lze dotaz napsat pouze jednou. Ukazuje, jak se u jednotlivých odvětvích
měnily mzdy rok po roce a díky window functions zobrazuje i rozdíl mzdy v daném
roce oproti loňsku.

> První samostatný select pak vrací pouze ty řádky z předchozího výsledku, kde
došlo k poklesu mzdy oproti minulému roku. Někde nastal pokles vícekrát,
například u těžby a dobývání čtyřikrát. Další select také používá pohled
v_payroll_difference_data a zobrazuje pouze ta odvětví, u kterých pokles oproti
minulému roku nikdy nenastal. Jsou to zdravotní a sociální péče, zpracovatelský
průmysl a ostatní činnosti. Díky poslednímu selectu se dá zjistit, že mzdy v
posledním srovnatelném období jsou oproti prvnímu srovnatelnému období u všech 
odvětví vždy vyšší, což znamená že mzdy vždy celkově vzrostly a klesly pouze 
lokálně.

2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední
srovnatelné období v dostupných datech cen a mezd?

> Ve výsledku dotazu je vidět, kolik litrů mléka a kilogramů chleba je možno 
koupit za mzdu v daném odvětví. Nejprve jednotlivě za každé odvětví v prvním 
srovnatelném období dostupných dat - v roce 2006 a dále v každém odvětví v 
posledním srovnatelném období - v roce 2018. 

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální
meziroční nárůst)?

> V dotazu se nejprve spočítá procentuální změna v ceně potraviny z roku na rok 
vydělením rozdílu současné a loňské ceny současnou cenou a podíl je vynásoben 
stem. Další select zjišťuje průměr těchto změn v ceně u každé kategorie potravin.
Nakonec se vrací ta kategorie, jejíž průměr změn v ceně je nejmenší z těch, které 
jsou větší než nula. Hledáme hodnoty větší než nula, protože nás zajímá zdražování 
a z nich nejmenší je ta cena, která se mění nejpomaleji.   

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než
růst mezd (větší než 10 %)?

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP
vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve
stejném nebo následujícím roce výraznějším růstem?

