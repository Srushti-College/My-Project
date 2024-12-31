variable "name" {
  type        = string
  default     = "devcloudgeek"
  description = "The name of the resource"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1" {
  type        = string
  description = "The CIDR block for the public subnet 1"
  default     = "10.0.1.0/16"
}

variable "public_subnet_2" {
  type        = string
  description = "The CIDR block for the public subnet 2"
  default     = "10.0.1.0/16"
}

variable "private_subnet_1" {
  type        = string
  description = "The CIDR block for the private subnet 1"
  default     = "10.0.3.0/16"
}

variable "private_subnet_2" {
  type        = string
  description = "The CIDR block for the private subnet 2"
  default     = "10.0.4.0/16"
}