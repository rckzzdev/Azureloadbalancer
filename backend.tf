
# To create backend storage pool 

terraform {
  backend "azurerm" {
    storage_account_name = "rag1841992"
    container_name       = "raghu18"
    key                  = "prod.terraform.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.
    access_key = "35YX39ozLUhORljUt6TRo4dsYloJgYbI011+qrsAM+zAuf2pmaKQftAURKy5DmVYfJwu2QIgWRck+ASt+aOYLA=="
  }
}
