variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-2"
}

variable "efs_name" {
  description = "The name of the EFS file system"
}

variable "vpc_id" {
  description = "The name of the VPC where you want to create the resources"
  type        = string
}

variable "subnets" {
  description = "The name of the Subnets"
  type        = list(string)
  default     = []
}

variable "az" {
  description = "The name of the Availability Zones"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "The name of the Security Groups"
  type = list(object({
    id = string
  }))
}

