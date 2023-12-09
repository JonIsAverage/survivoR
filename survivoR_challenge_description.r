# Databricks notebook source
library(sparklyr)
library(SparkR)

# COMMAND ----------

#assign R variables
rdataname <- "challenge_description"

# COMMAND ----------

# MAGIC %sh
# MAGIC advantage_details_variable="challenge_description"
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
# MAGIC CREATE OR REPLACE TABLE bronze_challenge_description
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM tmp_challenge_description;
# MAGIC
# MAGIC CREATE OR REPLACE TABLE gold_challenge_description
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM bronze_challenge_description
# MAGIC WHERE version = 'US';