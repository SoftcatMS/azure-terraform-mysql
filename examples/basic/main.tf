module "mysql_example" {
  source = "git@github.com:SoftcatMS/azure-terraform-mysql"

  name                = "mysql-example"
  location            = azurerm_resource_group.rg-mysql-example.location
  resource_group_name = azurerm_resource_group.rg-mysql-example.name
  random_suffix       = false

  administrator_login          = "example_admin"
  administrator_login_password = "C0mpl3xP4ssw0rd"

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120

  tags = {
    environment = "example"
    engineer    = "ci/cd"
  }

}
