variable "server_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "delegated_subnet_id" {
  type = string
}

variable "postgres_version" {
  type    = string
  default = "16"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "database_name" {
  type = string
}

variable "storage_mb" {
  type    = number
  default = 32768
}

variable "sku_name" {
  type    = string
  default = "B_Standard_B1ms"
}

variable "zone" {
  type    = string
  default = "1"
}

variable "tags" {
  type    = map(string)
  default = {}
}