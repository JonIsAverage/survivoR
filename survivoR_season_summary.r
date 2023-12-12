# Databricks notebook source
#library(sparklyr)
#library(SparkR)

# COMMAND ----------

#assign R variables
rdataname <- "season_summary"

# COMMAND ----------

# MAGIC %sh
# MAGIC advantage_details_variable="season_summary"
# MAGIC wget -O /dbfs/$advantage_details_variable.rda https://raw.githubusercontent.com/doehm/survivoR/master/data/$advantage_details_variable.rda

# COMMAND ----------

load(paste0("/dbfs/", rdataname,".rda"))
your_data_frame_name <- rdataname
df <- get(your_data_frame_name)
sp_df <- as.DataFrame(df)
createOrReplaceTempView(sp_df, (paste0("tmp_", rdataname)))

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC CREATE OR REPLACE TABLE bronze_season_summary
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM tmp_season_summary;
# MAGIC
# MAGIC CREATE OR REPLACE TABLE gold_season_summary
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM bronze_season_summary
# MAGIC WHERE version = 'US';