variable "rg" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet" {
  description = "Name of the virtual network"
  type        = string
}

variable "subnet" {
  description = "Name of the subnet"
  type        = string
}

variable "nic" {
  description = "Name of the network interface card"
  type        = string
}

variable "nsg" {
  description = "Name of the network security group"
  type        = string
}

variable "nsg_in_http" {
  description = "Name of the inbound HTTP rule for the network security group"
  type        = string
}

variable "nsg_in_ssh" {
  description = "Name of the inbound SSH rule for the network security group"
  type        = string
}

variable "public_ip" {
  description = "Name of the public IP address"
  type        = string
}

variable "dns" {
  description = "Name of the DNS server"
  type        = string
}

variable "vm" {
  description = "Name of the virtual machine"
  type        = string
}

variable "os_version" {
  description = "Version of the operating system"
  type        = string
}

variable "vm_sku" {
  description = "SKU of the virtual machine"
  type        = string
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "vm_password" {
  description = "password"
  type        = string
  sensitive   = true
}

variable "ip_config_name" {
  description = "Name of the IP configuration"
  type        = string
}
