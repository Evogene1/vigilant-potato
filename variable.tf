variable "REGION" {
  default = "eu-west-1"
}

variable "ZONE1" {
  default = "eu-west-1a"
}

variable "ZONE2" {
  default = "eu-west-1b"
}

variable "AMIS" {
  default = {
    eu-west-1 = "ami-01c7096235204c7be"
  }
}

variable "USER" {
  default = "your_user"
}

variable "PUB_KEY" {
  default = "your_key"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_public" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "subnet_cidr_private1" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_cidr_private2" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "white_list" {
  default = "0.0.0.0/0"
}

variable "access_key" {
    description = "*"
}
variable "secret_key" {
    description = "*"
}

variable "rds_user" {
  description = "RDS master username"
  default     = "your_user"
}

variable "rds_passwd" {
  description = "RDS master password"
  default     = "*"
}

variable "db_name" {
  default     = "your_db_name"
}
