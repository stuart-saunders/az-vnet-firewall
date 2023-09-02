locals {
  
  subnets = { for subnet in var.subnets :
    subnet.name => subnet
  }

  firewall_subnet = { for subnet in var.subnets :
    "this" => subnet
    if subnet.name == "AzureFirewallSubnet"
  }
}