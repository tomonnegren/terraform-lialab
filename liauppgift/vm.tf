# Network Interface Card VM1
resource "azurerm_network_interface" "prodnic" {
  name                = "prod-nic"
  location            = azurerm_resource_group.prod-rg.location
  resource_group_name = azurerm_resource_group.prod-rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    public_ip_address_id          = azurerm_public_ip.prodpip.id
  }
}

# Virtual Machine 1
resource "azurerm_windows_virtual_machine" "prodvm" {
  name                = "prod-vm"
  resource_group_name = azurerm_resource_group.prod-rg.name
  location            = azurerm_resource_group.prod-rg.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "Pa55word!"
  network_interface_ids = [
    azurerm_network_interface.prodnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Network Interface Card VM2
resource "azurerm_network_interface" "devnic" {
  name                = "dev-nic"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name

  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = azurerm_subnet.subnet3.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.2.1.10"
    public_ip_address_id          = azurerm_public_ip.devpip.id

  }
}

# Virtual Machine 2
resource "azurerm_windows_virtual_machine" "devvm" {
  name                = "dev-vm"
  resource_group_name = azurerm_resource_group.dev-rg.name
  location            = azurerm_resource_group.dev-rg.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "Pa55word!"
  network_interface_ids = [
    azurerm_network_interface.devnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}