module "core" {
  source = "../../modules/core"

  environment              = var.environment
  data_bucket_name         = var.data_bucket_name
  glue_assets_bucket_name  = var.glue_assets_bucket_name
  glue_scripts_bucket_name = var.glue_scripts_bucket_name
}

module "glue" {
  source = "../../modules/glue"

  environment            = var.environment
  data_bucket_id         = module.core.data_bucket_id
  glue_scripts_bucket_id = module.core.glue_scripts_bucket_id
  glue_service_role_id   = module.core.glue_service_role_id
}

module "athena" {
  source = "../../modules/athena"

  aws_account_id                   = var.aws_account_id
  aws_region                       = var.aws_region
  environment                      = var.environment
  athena_query_results_bucket_name = var.athena_query_results_bucket_name
  data_bucket_id                   = module.core.data_bucket_id
  silver_database_name             = module.glue.silver_database_name
}
