resource "azurerm_public_ip" "pip" {
    count=2
    name= var.pip-name[count.index]
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    allocation_method = var.all-name
      depends_on = [ azurerm_subnet.Snet]
}