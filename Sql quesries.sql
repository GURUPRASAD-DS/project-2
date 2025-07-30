#QUESTION-1-Year-wise Trend of Rice Production Across States (Top 3)
SELECT 
  cd.year, 
  cd.state_name, 
  SUM(cd.`rice_production_(1000_tons)`) AS total_rice_production
FROM 
  agridata.crop_details cd
JOIN (
  SELECT 
    state_name
  FROM 
    agridata.crop_details
  GROUP BY 
    state_name
  ORDER BY 
    SUM(`rice_production_(1000_tons)`) DESC
  LIMIT 3
) AS top_states
ON cd.state_name = top_states.state_name
GROUP BY 
  cd.year, cd.state_name
ORDER BY 
  cd.year DESC, total_rice_production DESC;
#-----------------------------------------------------------------------------------#
#Question-2:Top 5 Districts by Wheat Yield Increase Over the Last 5 Years
SELECT
  dist_name,
  AVG(`wheat_yield_(kg_per_ha)`) AS avg_wheat_yield
FROM
  agridata.crop_details
WHERE
  year >= 2015
GROUP BY
  dist_name
ORDER BY
  avg_wheat_yield DESC
LIMIT 5;
#-----------------------------------------------------------------------------------#
#QUESTION-3-States with the Highest Growth in Oilseed Production (5-Year Growth Rate)
SELECT
  state_name,
  SUM(`oilseeds_production_(1000_tons)`) AS total_oilseed_production
FROM
  agridata.crop_details
WHERE
  year >= 2015
GROUP BY
  state_name
ORDER BY
  total_oilseed_production DESC
LIMIT 5;
#-----------------------------------------------------------------------------------#
#QUESTION-4-District-wise Correlation Between Area and Production for Major Crops (Rice, Wheat, and Maize)
SELECT 
  dist_name,
  SUM(`rice_area_(1000_ha)`) AS rice_area,
  SUM(`rice_production_(1000_tons)`) AS rice_production,
  SUM(`wheat_area_(1000_ha)`) AS wheat_area,
  SUM(`wheat_production_(1000_tons)`) AS wheat_production,
  SUM(`maize_area_(1000_ha)`) AS maize_area,
  SUM(`maize_production_(1000_tons)`) AS maize_production
FROM 
  agridata.crop_details
GROUP BY 
  dist_name
ORDER BY 
  dist_name;
#-----------------------------------------------------------------------------------#
#QUESTION-5-Yearly Production Growth of Cotton in Top 5 Cotton Producing States:
WITH top_cotton_states AS (
  SELECT state_name
  FROM agridata.crop_details
  GROUP BY state_name
  ORDER BY SUM(`cotton_production_(1000_tons)`) DESC
  LIMIT 5
)
SELECT 
  year,
  state_name,
  SUM(`cotton_production_(1000_tons)`) AS total_cotton_production
FROM 
  agridata.crop_details
WHERE 
  state_name IN (SELECT state_name FROM top_cotton_states)
GROUP BY 
  year, state_name
ORDER BY 
  year DESC, total_cotton_production DESC;
  #-----------------------------------------------------------------------------------#
  #Question-6:Highest Groundnut Production Districts in 2020
  SELECT
  dist_name,
  SUM(`groundnut_production_(1000_tons)`) AS total_groundnut
FROM
  agridata.crop_details
WHERE
  year = 2018  -- Or whatever recent year you have
GROUP BY
  dist_name
ORDER BY
  total_groundnut DESC
LIMIT 5;
#-----------------------------------------------------------------------------------#
#Question-7: Annual Average Maize Yield
SELECT 
  year,
  AVG(`maize_yield_(kg_per_ha)`) AS avg_maize_yield
FROM 
  agridata.crop_details
GROUP BY 
  year
ORDER BY 
  year;
#-----------------------------------------------------------------------------------#
#Question-8:Total Oilseeds Area Cultivated in Each State:
SELECT
  state_name,
  SUM(`oilseeds_area_(1000_ha)`) AS total_oilseeds_area
FROM
  agridata.crop_details
GROUP BY
  state_name
ORDER BY
  total_oilseeds_area DESC;
#-----------------------------------------------------------------------------------#
#Question-9: Districts with the Highest Rice Yield:
SELECT
  dist_name,
  AVG(`rice_yield_(kg_per_ha)`) AS avg_rice_yield
FROM
  agridata.crop_details
GROUP BY
  dist_name
ORDER BY
  avg_rice_yield DESC
LIMIT 5;
#-----------------------------------------------------------------------------------#
#Question-10: Compare Wheat and Rice Production for Top 5 States Over Last 10 Years:
WITH top_states AS (
  SELECT state_name
  FROM agridata.crop_details
  GROUP BY state_name
  ORDER BY SUM(`rice_production_(1000_tons)` + `wheat_production_(1000_tons)`) DESC
  LIMIT 5
)
SELECT
  state_name,
  year,
  SUM(`rice_production_(1000_tons)`) AS total_rice,
  SUM(`wheat_production_(1000_tons)`) AS total_wheat
FROM
  agridata.crop_details
WHERE
  state_name IN (SELECT state_name FROM top_states)
  AND year >= YEAR(CURDATE()) - 10
GROUP BY
  state_name, year
ORDER BY
  state_name, year;

