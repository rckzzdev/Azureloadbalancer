resource "azurerm_availability_set" "aset" {
    name= "av-01"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  
}
resource "azurerm_linux_virtual_machine" "VM" {
    name= var.vm-name
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    network_interface_ids = [azurerm_network_interface.Nic.id]
    size = var.size-name
    availability_set_id = azurerm_availability_set.aset.id
     os_disk{
        name =var.disk-name
        caching = var.cac-name
        storage_account_type = var.sactype-name
     }
     source_image_reference {
       publisher = var.pub-name
       offer= var.machine-name
       sku = var.sku-name
       version= var.ver-name
     }
     computer_name= var.computer_name
     admin_username= var.admin-name
     disable_password_authentication= false
     admin_password= var.admin-pass
     #depends_on = [ azurerm_subnet_network_security_group_association.nsgassociation]

  
}
resource "azurerm_linux_virtual_machine" "VM-02" {
    name= var.vm-name2
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    network_interface_ids = [azurerm_network_interface.Nic-02.id]
    size = var.size-name
    availability_set_id = azurerm_availability_set.aset.id
     os_disk{
        name =var.disk-name2
        caching = var.cac-name
        storage_account_type = var.sactype-name
     }
     source_image_reference {
       publisher = var.pub-name
       offer= var.machine-name
       sku = var.sku-name
       version= var.ver-name
     }
     computer_name= var.computer_name
     admin_username= var.admin-name
     disable_password_authentication= false
     admin_password= var.admin-pass
     depends_on = [ azurerm_subnet_network_security_group_association.nsgassociation2 ]

  
}
