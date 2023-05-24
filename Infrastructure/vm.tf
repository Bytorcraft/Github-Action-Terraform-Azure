
resource "azurerm_virtual_network" "aut_vnet" {
  name                = "aut_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_aut.location
  resource_group_name = azurerm_resource_group.rg_aut.name
}

resource "azurerm_subnet" "aut_subnet" {
  name                 = "aut_subnet"
  resource_group_name  = azurerm_resource_group.rg_aut.name
  virtual_network_name = azurerm_virtual_network.aut_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "aut_net_inter" {
  name                = "aut_net_inter"
  location            = azurerm_resource_group.rg_aut.location
  resource_group_name = azurerm_resource_group.rg_aut.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.aut_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "aut_vm" {
  name                = "autvm"
  resource_group_name = azurerm_resource_group.rg_aut.name
  admin_username      = "azureuser"
  location            = azurerm_resource_group.rg_aut.location
  size                = "Standard_B1ls"

  network_interface_ids = [azurerm_network_interface.aut_net_inter.id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }
}