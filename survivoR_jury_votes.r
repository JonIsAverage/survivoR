# Databricks notebook source
library(sparklyr)
library(SparkR)

# COMMAND ----------

#assign R variables
rdataname <- "jury_votes"

# COMMAND ----------

# MAGIC %sh
# MAGIC advantage_details_variable="jury_votes"
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
# MAGIC CREATE OR REPLACE TABLE bronze_jury_votes
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM tmp_jury_votes;
# MAGIC
# MAGIC CREATE OR REPLACE TABLE gold_jury_votes
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM bronze_jury_votes
# MAGIC WHERE version = 'US';