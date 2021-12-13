# creates random password for mysql admin account
resource "random_password" "login_password" {
  length  = 24
  special = true
}

resource "azurerm_resource_group" "rg-mysql-test-basic" {
  name     = "rg-test-mysql-basic-resources"
  location = "UK South"
}

module "mysql_basic" {
  source = "../../"

  name                = "test-mysql-basic"
  location            = azurerm_resource_group.rg-mysql-test-basic.location
  resource_group_name = azurerm_resource_group.rg-mysql-test-basic.name
  random_suffix       = false

  administrator_login          = "test_admin"
  administrator_login_password = random_password.login_password.result

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }

  depends_on = [azurerm_resource_group.rg-mysql-test-basic]

}
