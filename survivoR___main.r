# Databricks notebook source
# MAGIC %md
# MAGIC A script to run all of the other scripts since this is on Databricks Community and I don't have access to workflows. 
# MAGIC Also note that the dbutils.notebook.run function requires a Databricks subscription.

# COMMAND ----------

library(sparklyr)
library(SparkR)

# COMMAND ----------

# MAGIC %run ./survivoR_AdvDetails

# COMMAND ----------

# MAGIC %run ./survivoR_castaway_details

# COMMAND ----------

# MAGIC %run ./survivoR_castaways

# COMMAND ----------

# MAGIC %run ./survivoR_challenge_results

# COMMAND ----------

# MAGIC %run ./survivoR_challenge_description

# COMMAND ----------

# MAGIC %run ./survivoR_confessionals

# COMMAND ----------

# MAGIC %run ./survivoR_jury_votes

# COMMAND ----------

# MAGIC %run ./survivoR_screen_time

# COMMAND ----------

# MAGIC %run ./survivoR_season_summary

# COMMAND ----------

# MAGIC %run ./survivoR_viewers

# COMMAND ----------

# MAGIC %run ./survivoR_vote_history