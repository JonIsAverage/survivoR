# Databricks notebook source
library(sparklyr)
library(SparkR)

# COMMAND ----------

#assign R variables
rdataname <- "screen_time"

# COMMAND ----------

# MAGIC %sh
# MAGIC advantage_details_variable="screen_time"
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
# MAGIC CREATE OR REPLACE TABLE bronze_screen_time
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM tmp_screen_time;
# MAGIC
# MAGIC CREATE OR REPLACE TABLE gold_screen_time
# MAGIC AS
# MAGIC SELECT *
# MAGIC FROM bronze_screen_time
# MAGIC WHERE version_season LIKE 'US%';