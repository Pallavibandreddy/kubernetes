variable "cluster_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "node_count" {
  type    = number
  default = 2
}

variable "vm_size" {
  type    = string
  default = "Standard_D2s_v5"
}

variable "subnet_id" {
  type = string
}

variable "acr_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

variable "application_gateway_id" {
  type = string
}


variable "resource_group_id" {
  type = string
}

variable "application_gateway_subnet_id" {
  type = string
}