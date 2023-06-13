# MGMT Groups; children of "Tenant Root Group"

# Landing Zones
resource "azurerm_management_group" "child1" {
  display_name               = "Landing Zones"
  parent_management_group_id = "/providers/Microsoft.Management/managementGroups/YOUR_PARENT_MGMT_GRP_ID"
}

# Platform
resource "azurerm_management_group" "child2" {
  display_name               = "Platform"
  parent_management_group_id = "/providers/Microsoft.Management/managementGroups/YOUR_PARENT_MGMT_GRP_ID"
}

# Decomissioned
resource "azurerm_management_group" "child3" {
  display_name               = "Decomissioned"
  parent_management_group_id = "/providers/Microsoft.Management/managementGroups/YOUR_PARENT_MGMT_GRP_ID"
}

# Sandbox
resource "azurerm_management_group" "child4" {
  display_name               = "Sandbox"
  parent_management_group_id = "/providers/Microsoft.Management/managementGroups/YOUR_PARENT_MGMT_GRP_ID"
}

# MGMT Groups; grandchildren of "Tenant Root Group"

# Landing Zones LIA; barn till "Landing Zones"
resource "azurerm_management_group" "grandchild1" {
  display_name               = "Landing Zones LIA"
  parent_management_group_id = azurerm_management_group.child1.id

  depends_on = [azurerm_management_group.child1]
}

# MGMT Groups; children of "Platform"

# Connectivity
resource "azurerm_management_group" "grandchild2" {
  display_name               = "Connectivity"
  parent_management_group_id = azurerm_management_group.child2.id

  depends_on = [azurerm_management_group.child2]
}

#Identity
resource "azurerm_management_group" "grandchild3" {
  display_name               = "Identity"
  parent_management_group_id = azurerm_management_group.child2.id

  depends_on = [azurerm_management_group.child2]
}

# Management 
resource "azurerm_management_group" "grandchild4" {
  display_name               = "Management"
  parent_management_group_id = azurerm_management_group.child2.id

  depends_on = [azurerm_management_group.child2]
}
