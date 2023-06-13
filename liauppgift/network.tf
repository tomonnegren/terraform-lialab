# Virtual Networks

# VNet1, Subnet1, NSG1
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = azurerm_resource_group.prod-rg.location
  resource_group_name = azurerm_resource_group.prod-rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.prod-rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg1"
  location            = azurerm_resource_group.prod-rg.location
  resource_group_name = azurerm_resource_group.prod-rg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet1_nsg1_association" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

# VNet2, Subnet2, NSG2
resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.test-rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_network_security_group" "nsg2" {
  name                = "nsg2"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet2_nsg2_association" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}

# VNet3, Subnet3, NSG3
resource "azurerm_virtual_network" "vnet3" {
  name                = "vnet3"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.dev-rg.name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_network_security_group" "nsg3" {
  name                = "nsg3"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet3_nsg3_association" {
  subnet_id                 = azurerm_subnet.subnet3.id
  network_security_group_id = azurerm_network_security_group.nsg3.id
}

# VNet4, Firewall Subnet, NSG4
resource "azurerm_virtual_network" "vnet4" {
  name                = "vnet4"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
  address_space       = ["10.3.0.0/16"]
}

resource "azurerm_subnet" "firewallsubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.vnet4.name
  address_prefixes     = ["10.3.1.0/24"]

}

resource "azurerm_subnet" "gatewaysubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.vnet4.name
  address_prefixes     = ["10.3.2.0/24"]
}

resource "azurerm_network_security_group" "nsg4" {
  name                = "nsg4"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
}
# VNet5, Subnet5, NSG5
resource "azurerm_virtual_network" "vnet5" {
  name                = "vnet5"
  location            = azurerm_resource_group.egetvnetrg.location
  resource_group_name = azurerm_resource_group.egetvnetrg.name
  address_space       = ["10.4.0.0/16"]
}

resource "azurerm_subnet" "subnet5" {
  name                 = "subnet5"
  resource_group_name  = azurerm_resource_group.egetvnetrg.name
  virtual_network_name = azurerm_virtual_network.vnet5.name
  address_prefixes     = ["10.4.1.0/24"]
}

resource "azurerm_network_security_group" "nsg5" {
  name                = "nsg5"
  location            = azurerm_resource_group.egetvnetrg.location
  resource_group_name = azurerm_resource_group.egetvnetrg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet5_nsg5_association" {
  subnet_id                 = azurerm_subnet.subnet5.id
  network_security_group_id = azurerm_network_security_group.nsg5.id
}

# NSG rules; allow inbound and outbound 3389

resource "azurerm_network_security_rule" "nsgrule1" {
  name                        = "prod-allow-inbound-rdp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.prod-rg.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}
resource "azurerm_network_security_rule" "nsgrule2" {
  name                        = "prod-allow-outbound-rdp"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.prod-rg.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}

resource "azurerm_network_security_rule" "nsgrule3" {
  name                        = "dev-allow-inbound-rdp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.dev-rg.name
  network_security_group_name = azurerm_network_security_group.nsg3.name
}

resource "azurerm_network_security_rule" "nsgrule4" {
  name                        = "dev-allow-outbound-rdp"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.dev-rg.name
  network_security_group_name = azurerm_network_security_group.nsg3.name
}

# Route table, user-defined routes för att routa genom Firewall 

# UDR for VNet1
resource "azurerm_route_table" "vnet1udr" {
  name                = "vnet1-udr"
  resource_group_name = azurerm_resource_group.prod-rg.name
  location            = azurerm_resource_group.prod-rg.location
}

resource "azurerm_route" "vnet1_route" {
  name                   = "vnet1-route"
  resource_group_name    = azurerm_resource_group.prod-rg.name
  route_table_name       = azurerm_route_table.vnet1udr.name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

# Associate UDR with VNet1 subnet
resource "azurerm_subnet_route_table_association" "vnet1association" {
  subnet_id      = azurerm_subnet.subnet1.id
  route_table_id = azurerm_route_table.vnet1udr.id
}

# UDR for VNet3
resource "azurerm_route_table" "vnet3udr" {
  name                = "vnet3-udr"
  resource_group_name = azurerm_resource_group.dev-rg.name
  location            = azurerm_resource_group.dev-rg.location
}

resource "azurerm_route" "vnet3route" {
  name                   = "vnet3-route"
  resource_group_name    = azurerm_resource_group.dev-rg.name
  route_table_name       = azurerm_route_table.vnet3udr.name
  address_prefix         = "10.0.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

# Associate UDR with VNet3 subnet
resource "azurerm_subnet_route_table_association" "vnet3association" {
  subnet_id      = azurerm_subnet.subnet3.id
  route_table_id = azurerm_route_table.vnet3udr.id
}