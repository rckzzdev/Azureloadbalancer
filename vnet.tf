resource "azurerm_virtual_network" "vnet" {
name = var.vnet-name
address_space = var.ip-address
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
}
    resource "azurerm_subnet" "Snet" {
    count=3
    name = element(var.sub-net, count.index)
    address_prefixes = [element(var.ip-name,count.index)]
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg.name
    depends_on = [ azurerm_virtual_network.vnet ]
  
}