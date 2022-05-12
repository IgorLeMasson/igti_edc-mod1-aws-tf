resource "aws_glue_catalog_database" "glue_database" {
  name = "igti-glue-database"
}

resource "aws_glue_crawler" "glue_crawler" {
  database_name = aws_glue_catalog_database.glue_database.name
  name          = "igti-glue-update-rais"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.data_lake.bucket}/rais"
  }

  depends_on = [
    aws_s3_object.object,
  ]
}

resource "aws_glue_job" "igti_glue_job_rais" {
  name     = "igti-rais-etl"
  role_arn = aws_iam_role.glue_role.arn

  command {
    script_location = "s3://${aws_s3_bucket.scripts.bucket}/rais_etl.py"
  }
}

resource "aws_glue_trigger" "igti_glue_job_rais_trigger" {
  name = "igti-rais-etl-trigger"
  type = "ON_DEMAND"

  actions {
    job_name = aws_glue_job.igti_glue_job_rais.name
  }
}