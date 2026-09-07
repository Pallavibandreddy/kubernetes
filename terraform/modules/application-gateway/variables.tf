variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "backend_ip_addresses" {
  type    = list(string)
  default = []
}

variable "backend_port" {
  type    = number
  default = 80
}

variable "tags" {
  type    = map(string)
  default = {}
}