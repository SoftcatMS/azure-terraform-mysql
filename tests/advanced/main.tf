# creates random password for mysql admin account
resource "random_password" "login_password" {
  length  = 24
  special = true
}

resource "azurerm_resource_group" "rg-mysql-test-advanced" {
  name     = "rg-test-mysql-advanced-resources"
  location = "westeurope"
}

module "mysql_advanced" {
  source = "../../"

  name                = "test-mysql-advanced"
  location            = azurerm_resource_group.rg-mysql-test-advanced.location
  resource_group_name = azurerm_resource_group.rg-mysql-test-advanced.name

  administrator_login          = "test_admin"
  administrator_login_password = random_password.login_password.result

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120

  auto_grow_enabled                = true
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = true
  encryption_enabled               = true
  public_access                    = false
  force_ssl                        = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }


  databases = {
    testdb1 = {
      resource_group_name = azurerm_resource_group.rg-mysql-test-advanced.name
      charset             = "utf8"
      collation           = "utf8_unicode_ci"
    },
    testdb2 = {
      resource_group_name = azurerm_resource_group.rg-mysql-test-advanced.name
      charset             = "utf8"
      collation           = "utf8_unicode_ci"
    }
  }

  depends_on = [azurerm_resource_group.rg-mysql-test-advanced]

}
