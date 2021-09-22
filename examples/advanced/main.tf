module "mysql_example" {
  source              = "github.com/SoftcatMS/azure-terraform-mysql"

  name                = "mysql-example"
  location            = azurerm_resource_group.rg-mysql-example.location
  resource_group_name = azurerm_resource_group.rg-mysql-example.name

  administrator_login          = "example_admin"
  administrator_login_password = "C0mpl3xP4ssw0rd"

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  encryption_enabled                = true
  public_access                     = false
  force_ssl                         = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"

  tags = {
    environment = "example"
    engineer    = "ci/cd"
  }


  databases = {
    exampledb2 = {
      resource_group_name =  azurerm_resource_group.rg-mysql-example.name
      charset             = "utf8"
      collation           = "utf8_unicode_ci"
    },
    exampledb2 = {
      resource_group_name =  azurerm_resource_group.rg-mysql-example.name
      charset             = "utf8"
      collation           = "utf8_unicode_ci"
    }
  }

}
