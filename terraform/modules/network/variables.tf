variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "aks_subnet_name" {
  type = string
}

variable "aks_subnet_prefix" {
  type = list(string)
}

variable "app_gateway_subnet_name" {
  type = string
}

variable "app_gateway_subnet_prefix" {
  type = list(string)
}

variable "private_endpoint_subnet_name" {
  type = string
}

variable "private_endpoint_subnet_prefix" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "postgres_subnet_prefix" {
  type = list(string)
}