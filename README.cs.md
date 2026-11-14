🇬🇧 English | [🇨🇿 Čeština](README.cs.md)

---

# Projekt z SQL 

## Cíl 

Cílem projektu bylo odpovědět na otázky, které se týkaly dostupnosti základních
potravin pro širokou veřejnost, jako kdybychom pracovali pro organizaci
zabývající se životní úrovní občanů. Hlavní úkol spočíval v porovnání
dostupnosti potravin na základě průměrných příjmů za určité časové období.

Projekt navíc obsahuje i data o dalších evropských státech ve stejném období
jako primární přehled pro ČR.

## Základní tabulky
V této části jsou popsány tabulky, ze kterých lze získat odpovědi na výzkumné 
otázky.

1. t_lukas_janouch_project_SQL_primary_final

> Tato tabulka obsahuje data mezd a cen potravin za Českou republiku sjednocená 
na totožné porovnatelné období – společné roky. Vznikla tedy z původních tabulek 
v databázi - czechia_payroll, czechia_price, czechia_payroll_value_type, 
czechia_payroll_unit, czechia_payroll_calculation, czechia_payroll_industry_branch,
czechia_price_category a czechia_region. První dvě tabulky z výčtu - tabulka mezd a 
tabulka cen vybraných potravin jsou propojeny pomocí roku, za který mzda nebo cena 
platí. Aby byly hodnoty srovnatelné, bylo potřeba je zprůměrovat a vznikly sloupce 
yearly_payroll a yearly_price, tedy roční mzda a roční cena. Mzdy byly původně 
uvedeny za každý kvartál a ceny potravin za několik dní, například od 13. do 17. 
listopadu. Rok je proto z datumu uvedený u ceny potraviny získáván pomocí funkce 
date_part(). 

> V původní tabulce mezd jsou uvedeny hodnoty pro oba dva způsoby kalkulace mezd - 
pro fyzický i přepočtený. V klauzuli WHERE dotazu pro vytvoření tabulky je vybrán 
přepočtený, protože zohledňuje i to, že někteří zaměstanci pracují pouze na 
částečný úvazek. Dále jsou zde data omezena pouze na mzdy, co se týče hodnoty 
czechia_payroll_value_type, protože druhým typem je počet zaměstaných osob v 
odvětví a toho se výzkumné otázky netýkají. 

2. t_lukas_janouch_project_SQL_secondary_final

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

> Zde se ke každému roku počítá průměrný plat za všechny obory v databázi (kategorie 
mezd) a průměrná cena potraviny za všechny druhy potravin (kategorie cen). Po zjištění 
procentuálních rozdílů cen a mezd oproti předešlému roku je zjištěn rozdíl mezi těmito 
dvěma hodnotami. Největší rozdíl procentuálním růstem cen a mezd je 6,65. To znamená, 
že růst cen byl maximálně o 6,65 % vyšší a nikdy nebyl vyšší než 10 %.   

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP
vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve
stejném nebo následujícím roce výraznějším růstem?

> Z dat je patrné, že HDP může mít vliv na změny ve mzdách a cenách, ale ne vždy 
se tyto proměnné chovají úplně stejně jako HDP, protože jsou ovlivněny i jinými 
faktory. Například v roce 2009 sice HDP a ceny potravin klesly, ale mzdy navzdory 
tomu vzrostly. V roce 2014 naopak HDP i mzdy vzrostly, zatímco ceny potravin rostly 
jen velmi mírně a v letech 2015 a 2016 došlo k jejich poklesu, odkud opět rostly 
společně s oživením HDP v roce 2017.   

