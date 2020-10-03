provider "azurerm" {
  version         = "1.38.0"
  subscription_id = var.sub
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "DevRG" {
  name     = "Dev10"
  location = "westeurope"

  tags = {
    environment = "Dev"
  }
}


resource "azurerm_container_group" "example" {
  name                = "test-container-group"
  location            = azurerm_resource_group.DevRG.location
  resource_group_name = azurerm_resource_group.DevRG.name
  ip_address_type     = "public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "microsoft/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443,80
      protocol = "TCP"
    }
  }
}