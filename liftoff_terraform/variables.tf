variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for private subnets"
  default     = "10.0.2.0/24"
}

variable "private_network_interface_ip0" {
  type        = list(string)
  description = "IP address for the private NI jump host"
  default     = ["10.0.2.10"]
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for private subnets"
  default     = "10.0.3.0/24"
}

variable "all_cidr_blocks" {
  type        = string
  description = "List of CIDR blocks for the allowed ingress"
  default     = "0.0.0.0/0"
}

variable "all_cidr_blocks_sg" {
  type        = list(string)
  description = "List of CIDR blocks for the allowed ingress"
  default     = ["0.0.0.0/0"]
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_sg" {
  type        = list(string)
  description = "CIDR block for the private subnets"
  default     = ["10.0.0.0/16"]
}
