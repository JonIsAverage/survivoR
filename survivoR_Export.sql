-- Databricks notebook source
SET delta_table_path = '/user/hive/warehouse/gold_adv_details';

SET csv_export_path = '/user/hive/warehouse/exported_csv';

OPTIMIZE delta.`/user/hive/warehouse/gold_adv_details`;

INSERT OVERWRITE DIRECTORY '/user/hive/warehouse/exported_csv'
SELECT * FROM delta.`/user/hive/warehouse/gold_adv_details`;

-- COMMAND ----------

-- MAGIC %python
-- MAGIC import requests
-- MAGIC from requests.auth import HTTPBasicAuth
-- MAGIC import base64
-- MAGIC
-- MAGIC fn = 'advantage_details'
-- MAGIC
-- MAGIC github_user = "JonIsAverage"
-- MAGIC github_repo = "survivoR"
-- MAGIC github_token = ""
-- MAGIC
-- MAGIC local_path = '/user/hive/warehouse/exported_csv'
-- MAGIC api_url = f"https://api.github.com/repos/{github_user}/{github_repo}/contents/exported_csv"
-- MAGIC
-- MAGIC files = dbutils.fs.ls(local_path)
-- MAGIC for file in files:
-- MAGIC     file_name = file.name
-- MAGIC     if not file_name.startswith("_"):
-- MAGIC         file_content = dbutils.fs.head(file.path)
-- MAGIC
-- MAGIC         file_content_bytes = file_content.encode("utf-8")
-- MAGIC
-- MAGIC         file_content_base64 = base64.b64encode(file_content_bytes).decode("utf-8")
-- MAGIC
-- MAGIC         headers = {"Authorization": f"token {github_token}"}
-- MAGIC         data = {
-- MAGIC             "message": f"Automated Export from Delta Table: {fn}",
-- MAGIC             "content": file_content_base64,
-- MAGIC             "committer": {
-- MAGIC                 "name": github_user,
-- MAGIC                 "email": f"{github_user}@users.noreply.github.com"
-- MAGIC             },
-- MAGIC             "path": fn
-- MAGIC         }
-- MAGIC
-- MAGIC         response = requests.put(api_url + f"/{fn}", headers=headers, json=data, auth=HTTPBasicAuth(github_user, github_token))
-- MAGIC
-- MAGIC         if response.status_code == 201 or response.status_code == 200:
-- MAGIC             print(f"Success! Added: {fn} to GitHub.")
-- MAGIC         else:
-- MAGIC             print(f"Failed! {fn} Status code: {response.status_code}, Response: {response.text}")
