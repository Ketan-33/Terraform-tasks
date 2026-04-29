locals {
  rg_name         = join("-", [var.name_prefix, "rg"])
  sql_server_name = join("-", [var.name_prefix, "sql"])
  sql_db_name     = join("-", [var.name_prefix, "sql", "db"])
  asp_name        = join("-", [var.name_prefix, "asp"])
  app_name        = join("-", [var.name_prefix, "app"])
}