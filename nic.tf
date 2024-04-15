resource "azurerm_network_interface" "Nic" {
    name= var.nic-name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    depends_on = [ azurerm_public_ip.pip ]

    ip_configuration{
        name =  "ipconfig"
        subnet_id = azurerm_subnet.Snet[0].id
    private_ip_address_allocation = var.pipall-name
    public_ip_address_id = azurerm_public_ip.pip[0].id

    }  
    
}
resource "azurerm_network_interface" "Nic-02" {
    name= var.nic-name2
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
   
depends_on = [ azurerm_network_interface.Nic ]
    ip_configuration{
        name =  "ipconfig"
        subnet_id = azurerm_subnet.Snet[1].id
    private_ip_address_allocation = var.pipall-name
    public_ip_address_id = azurerm_public_ip.pip[1].id

    }  
}


resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
    subnet_id = azurerm_subnet.Snet[0].id
    network_security_group_id = azurerm_network_security_group.NSG.id
    }
    resource "azurerm_subnet_network_security_group_association" "nsgassociation2" {
    subnet_id = azurerm_subnet.Snet[1].id
    network_security_group_id = azurerm_network_security_group.NSG.id
    depends_on = [ azurerm_subnet_network_security_group_association.nsgassociation ]
    }



