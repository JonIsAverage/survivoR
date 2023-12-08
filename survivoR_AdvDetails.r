# Databricks notebook source
library(sparklyr)
library(SparkR)

# COMMAND ----------

# MAGIC %sh
# MAGIC wget -O /dbfs/advantage_details.rda https://raw.githubusercontent.com/doehm/survivoR/master/data/advantage_details.rda

# COMMAND ----------

load("/dbfs/advantage_details.rda")
your_data_frame_name <- "advantage_details"
df <- get(your_data_frame_name)
sp_df <- as.DataFrame(df)
createOrReplaceTempView(sp_df, "tmp_advantage_details")

# COMMAND ----------

# MAGIC %sql
# MAGIC CREATE OR REPLACE TABLE bronze_adv_details
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM tmp_advantage_details;
# MAGIC
# MAGIC CREATE OR REPLACE TABLE gold_adv_details
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM tmp_advantage_details
# MAGIC WHERE version = 'US';
