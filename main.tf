resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

locals {
  suffix = var.random_suffix ? "${random_string.unique.result}" : ""
}


resource "azurerm_mysql_server" "mysql_server" {
  name = lower(join("", [var.name, (local.suffix)]))

  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.mysql_version

  auto_grow_enabled                 = var.auto_grow_enabled
  backup_retention_days             = var.backup_retention_days
  create_mode                       = var.create_mode
  creation_source_server_id         = var.creation_source_server_id
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  infrastructure_encryption_enabled = var.encryption_enabled
  public_network_access_enabled     = var.public_access
  restore_point_in_time             = var.restore_point_in_time
  ssl_enforcement_enabled           = var.force_ssl
  ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced

  tags = var.tags

}

resource "azurerm_mysql_database" "mysql_database" {

  for_each = var.databases

  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = lower(join("", [var.name, (local.suffix)]))
  charset             = each.value.charset
  collation           = each.value.collation

  depends_on = [azurerm_mysql_server.mysql_server]

}