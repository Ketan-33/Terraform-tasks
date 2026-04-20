locals {
  rg_name         = "${var.name_prefix}-rg"
  sql_server_name = "${var.name_prefix}-sql"
  sql_db_name     = "${var.name_prefix}-sql-db"
  asp_name        = "${var.name_prefix}-asp"
  app_name        = "${var.name_prefix}-app"
}