output "id" {
  value = azurerm_private_endpoint.this.id
}

output "name" {
  value = azurerm_private_endpoint.this.name
}

output "network_interface_id" {
  value = azurerm_private_endpoint.this.network_interface[0].id
}