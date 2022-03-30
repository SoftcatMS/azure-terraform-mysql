resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

locals {
  suffix = var.random_suffix ? "${random_string.unique.result}" : ""
}


resource "azurerm_mysql_server" "mysql_server" {
  #checkov:skip=CKV2_AZURE_16:Ensure that MySQL server enables customer-managed key for encryption
  #checkov:skip=CKV_AZURE_53:Ensure 'public network access enabled' is set to 'False' for mySQL servers (Defaults to 'False' in variables)
  #checkov:skip=CKV_AZURE_54:Ensure MySQL is using the latest version of TLS encryption (Defaults to TLS1_2 in variables)
  #checkov:skip=CKV_AZURE_96:Ensure MySQL server enables infrastructure encryption (Defaults to true in variables)
  #checkov:skip=CKV_AZURE_127:Ensure that My SQL server enables Threat detection policy
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

  dynamic "threat_detection_policy" {
    for_each = var.enable_threat_detection_policy == true ? [1] : []
    content {
      enabled                    = var.enable_threat_detection_policy
      disabled_alerts            = var.threat_detection_disabled_alerts
      email_account_admins       = var.threat_detection_email_addresses_for_alerts != null ? true : false
      email_addresses            = var.threat_detection_email_addresses_for_alerts
      retention_days             = var.threat_detection_log_retention_days
      storage_account_access_key = var.threat_detection_primary_access_key
      storage_endpoint           = var.threat_detection_primary_blob_endpoint
    }
  }


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
