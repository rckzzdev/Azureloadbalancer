resource "azurerm_resource_group" "rg" {
    name = var.name
    location = var.loc-name[1]
  
}