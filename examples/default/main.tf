provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-db-testing"
  location = "uksouth"
}

resource "azurerm_mssql_server" "main" {
  name                         = "sqs-actest-9ou-01"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = ""
  administrator_login_password = ""
  minimum_tls_version          = "1.2"
}

module "sql_db" {
  source = "../../"

  sql_db_name   = "dev01"
  sql_server_id = azurerm_mssql_server.main.id
}