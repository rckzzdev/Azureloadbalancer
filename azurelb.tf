resource "azurerm_public_ip" "PIP-01" {
    name= var.public-name1
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    allocation_method = "Static"
    
    }
resource "azurerm_lb" "ALB" {
    name=var.alb-name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
        
    frontend_ip_configuration {
      name=var.fip-name
      public_ip_address_id = azurerm_public_ip.PIP-01.id
          }
    
}

resource "azurerm_lb_backend_address_pool" "Bpool" {
  loadbalancer_id = azurerm_lb.ALB.id
  name            = "Bpool"
  depends_on = [ azurerm_lb.ALB, azurerm_availability_set.aset ]

}

resource "azurerm_network_interface_backend_address_pool_association" "BP-01" {
    network_interface_id = azurerm_network_interface.Nic.id
    ip_configuration_name = "ipconfig"
    backend_address_pool_id = azurerm_lb_backend_address_pool.Bpool.id
  
}
resource "azurerm_network_interface_backend_address_pool_association" "BP-02" {
    network_interface_id = azurerm_network_interface.Nic-02.id
    ip_configuration_name = "ipconfig"
    backend_address_pool_id = azurerm_lb_backend_address_pool.Bpool.id
    depends_on = [ azurerm_network_interface_backend_address_pool_association.BP-01 ]
    
  
}
resource "azurerm_lb_probe" "HP" {
  loadbalancer_id = azurerm_lb.ALB.id
    name            = "Hp-01"
  port            = 80
  depends_on = [ azurerm_availability_set.aset ]
}

resource "azurerm_lb_rule" "LB-rule" {
  loadbalancer_id                = azurerm_lb.ALB.id
    name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.fip-name
    probe_id = azurerm_lb_probe.HP.id
    backend_address_pool_ids = [azurerm_lb_backend_address_pool.Bpool.id]
    depends_on = [ azurerm_lb.ALB, azurerm_availability_set.aset, azurerm_lb_probe.HP ]

}

