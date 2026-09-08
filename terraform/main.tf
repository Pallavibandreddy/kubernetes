module "rg" {
  source = "./modules/rg"

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    project = "aks-kubernetes"
    env     = "dev"
  }
}


module "network" {
  source = "./modules/network"

  resource_group_name = module.rg.name
  location            = module.rg.location

  vnet_name = var.vnet_name

  vnet_address_space = [
    "10.0.0.0/16"
  ]

  aks_subnet_name = "aks-subnet"

  aks_subnet_prefix = [
    "10.0.1.0/24"
  ]

  postgres_subnet_prefix = [
    "10.0.4.0/24"
  ]

  app_gateway_subnet_name = "appgw-subnet"

  app_gateway_subnet_prefix = [
    "10.0.2.0/24"
  ]

  private_endpoint_subnet_name = "private-endpoint-subnet"

  private_endpoint_subnet_prefix = [
    "10.0.3.0/24"
  ]

  tags = {
    project = "aks-kubernetes"
    env     = "dev"
  }
}


module "acr" {
  source = "./modules/acr"

  name                = var.acr_name
  resource_group_name = module.rg.name
  location            = module.rg.location

  sku = "Basic"

  tags = {
    project = "aks-kubernetes"
    env     = "dev"
  }
}

module "aks" {
  source = "./modules/aks"

  cluster_name        = var.aks_name
  location            = module.rg.location
  resource_group_name = module.rg.name
  dns_prefix          = var.aks_dns_prefix

  resource_group_id = module.rg.id
  subnet_id         = module.network.aks_subnet_id
  acr_id            = module.acr.id

  application_gateway_id        = module.application_gateway.id
  application_gateway_subnet_id = module.network.app_gateway_subnet_id
  node_count                    = 2
  vm_size                       = "Standard_D2s_v5"

  service_cidr   = var.aks_service_cidr
  dns_service_ip = var.aks_dns_service_ip

  tags = {
    project = "aks-kubernetes"
    env     = "dev"
  }
}

module "sql" {
  source = "./modules/sql"

  server_name         = var.postgres_server_name
  resource_group_name = module.rg.name
  location            = module.rg.location

  admin_username = var.postgres_admin_username
  admin_password = var.postgres_admin_password

  database_name = var.postgres_database_name

  postgres_version = "16"
  storage_mb       = 32768
  sku_name         = "B_Standard_B1ms"
  zone             = "1"

  tags = {
    project = "aks-kubernetes"
    env     = "dev"
  }
}

module "private_endpoint" {
  source = "./modules/private-endpoint"

  name                = "pallavi-postgres-pe"
  location            = module.rg.location
  resource_group_name = module.rg.name

  subnet_id = module.network.private_endpoint_subnet_id
  vnet_id   = module.network.vnet_id

  private_connection_resource_id = module.sql.server_id

  subresource_names = ["postgresqlServer"]

  tags = {
    project = "aks-kubernetes"
    env     = "dev"
  }
}

module "application_gateway" {
  source = "./modules/application-gateway"

  name                = var.application_gateway_name
  resource_group_name = module.rg.name
  location            = module.rg.location

  subnet_id = module.network.app_gateway_subnet_id

  backend_ip_addresses = []

  backend_port = 80

  tags = {
    project = "aks-kubernetes"
    env     = "dev"
  }
}