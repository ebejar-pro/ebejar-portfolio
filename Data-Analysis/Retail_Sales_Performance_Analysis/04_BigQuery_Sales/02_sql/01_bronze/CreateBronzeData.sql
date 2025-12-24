CREATE SCHEMA IF NOT EXISTS `bq-analysis-04.retail_bronze`
OPTIONS (
  location = "australia-southeast1",
  description = "Bronze layer for raw retail data"
);