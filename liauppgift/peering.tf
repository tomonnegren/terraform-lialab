# Network Peerings

# VNet 1 to VNet 4
resource "azurerm_virtual_network_peering" "vnet1tovnet4" {
  name                      = "peer1to4"
  resource_group_name       = azurerm_resource_group.prod-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet4.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "vnet4tovnet1" {
  name                      = "peer4to1"
  resource_group_name       = azurerm_resource_group.hub-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet4.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
  allow_forwarded_traffic   = true
}

# VNet 2 to VNet 4
resource "azurerm_virtual_network_peering" "vnet2tovnet4" {
  name                      = "peer2to4"
  resource_group_name       = azurerm_resource_group.test-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet4.id
}

resource "azurerm_virtual_network_peering" "vnet4tovnet2" {
  name                      = "peer4to2"
  resource_group_name       = azurerm_resource_group.hub-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet4.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}

# VNet 3 to VNet 4 
resource "azurerm_virtual_network_peering" "vnet3tovnet4" {
  name                      = "peer3to4"
  resource_group_name       = azurerm_resource_group.dev-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet3.name
  remote_virtual_network_id = azurerm_virtual_network.vnet4.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "vnet4tovnet3" {
  name                      = "peer4to3"
  resource_group_name       = azurerm_resource_group.hub-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet4.name
  remote_virtual_network_id = azurerm_virtual_network.vnet3.id
  allow_forwarded_traffic   = true
}

# VNet 5 to VNet 4
resource "azurerm_virtual_network_peering" "vnet5tovnet4" {
  name                      = "peer5to4"
  resource_group_name       = azurerm_resource_group.egetvnetrg.name
  virtual_network_name      = azurerm_virtual_network.vnet5.name
  remote_virtual_network_id = azurerm_virtual_network.vnet4.id
}

resource "azurerm_virtual_network_peering" "vnet4tovnet5" {
  name                      = "peer4to5"
  resource_group_name       = azurerm_resource_group.hub-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet4.name
  remote_virtual_network_id = azurerm_virtual_network.vnet5.id
}