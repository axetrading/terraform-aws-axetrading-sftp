variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-2"
}

### VPC, AZ, SG
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

### EFS
variable "efs_name" {
  description = "The name of the EFS file system"
}


### SFTP
variable "create_sftp_server" {
  description = "Flag to create an AWS Transfer Family SFTP server"
  type        = bool
  default     = false
}

variable "sftp_name" {
  description = "The name of the SFTP server"
}

variable "sftp_user_name" {
  description = "The username for the SFTP user"
}

