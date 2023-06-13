# Firewall PIP
resource "azurerm_public_ip" "firewallpip" {
  name                = "firewall-pip"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Firewall
resource "azurerm_firewall" "firewall" {
  name                = "firewall"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
  sku_tier            = "Standard"
  sku_name            = "AZFW_VNet"
  firewall_policy_id  = azurerm_firewall_policy.firewallpolicy.id

  ip_configuration {
    name                 = "FirewallIPConfig"
    subnet_id            = azurerm_subnet.firewallsubnet.id
    public_ip_address_id = azurerm_public_ip.firewallpip.id
  }
}

# Firewall Policy
resource "azurerm_firewall_policy" "firewallpolicy" {
  name                = "firewall-policy"
  resource_group_name = azurerm_resource_group.hub-rg.name
  location            = azurerm_resource_group.hub-rg.location
}

# Firewall Rule Collection
resource "azurerm_firewall_policy_rule_collection_group" "networkrulecollectiongroup" {
  name               = "network-rule-collection-group"
  firewall_policy_id = azurerm_firewall_policy.firewallpolicy.id
  priority           = "200"

  network_rule_collection {
    name     = "network_rule1"
    priority = 300
    action   = "Allow"


    rule {
      name                  = "allow-vnet1-to-vnet3"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["10.0.0.0/16"]
      destination_addresses = ["10.2.0.0/16"]
      destination_ports     = ["*"]
    }

    rule {
      name                  = "allow-vnet3-to-vnet1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["10.2.0.0/16"]
      destination_addresses = ["10.0.0.0/16"]
      destination_ports     = ["*"]
    }
  }

  nat_rule_collection {
    name     = "nat_rule_collection"
    priority = 200
    action   = "Dnat"

    rule {
      name                = "allowrdp1"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["*"]
      destination_address = azurerm_public_ip.firewallpip.ip_address
      translated_address  = "10.0.1.10"
      destination_ports   = ["3389"]
      translated_port     = "3389"
    }
  

    rule {
      name                = "allowrdp"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["*"]
      destination_address = azurerm_public_ip.firewallpip.ip_address
      translated_address  = "10.2.1.10"
      destination_ports   = ["3389"]
      translated_port     = "3389"
    }
  }
}
