-- Databricks notebook source
--Top Players by Confessionals
select 
  c.full_name, sum(confessional_count) as TotalConfessionals
from gold_confessionals conf
LEFT JOIN gold_castaways c on conf.castaway_id = c.castaway_id
group by conf.castaway_id, c.full_name
order by TotalConfessionals desc

-- COMMAND ----------

--Top Seasons by Total Number of Viewers
select 
  v.season_name, v.version_season, ss.premiered as ReleaseDate, sum(v.viewers) as TotalViewers
from gold_viewers v
LEFT JOIN gold_season_summary ss on v.version_season = ss.version_season
group by v.season_name, v.version_season, ss.premiered
order by TotalViewers desc;