resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  version                = var.postgres_version
  administrator_login    = var.admin_username
  administrator_password = var.admin_password

  storage_mb = var.storage_mb
  sku_name   = var.sku_name
  zone       = var.zone

  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}