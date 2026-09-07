variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "aks_dns_prefix" {
  type = string
}

variable "postgres_server_name" {
  type = string
}

variable "postgres_admin_username" {
  type = string
}

variable "postgres_admin_password" {
  type      = string
  sensitive = true
}

variable "postgres_database_name" {
  type = string
}

variable "application_gateway_name" {
  type = string
}

variable "aks_service_cidr" {
  type = string
}

variable "aks_dns_service_ip" {
  type = string
}