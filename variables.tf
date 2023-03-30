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
  description = "A map of subnets to availability zones"
  type        = list(string)
  default     = []
}

variable "security_group_rules" {
  description = "A map of security group  rule definitions to add to the security group created"
  type        = map(any)
  default     = {}
}

variable "create_security_group" {
  description = "Determines whether to create security group for EFS Mount"
  type        = bool
  default     = true
}

variable "security_group_name" {
  type        = string
  description = "Security Group Name"
  default     = ""
}

variable "security_groups" {
  type        = list(string)
  description = "A list of security group ids that should be attached to EFS Mount"
  default     = []
}


### EFS
variable "efs_name" {
  type        = string
  description = "Efs name"
  default     = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}


variable "performance_mode" {
  type        = string
  description = "Efs performance mode"
  default     = "generalPurpose"
}

variable "throughput_mode" {
  type        = string
  description = "Efs throughput mode"
  default     = "bursting"
}

### IAM
variable "create_iam_role" {
  description = "Flag to create an IAM role for SFTP users"
  type        = bool
  default     = true
}

variable "provided_iam_role_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) of an existing IAM role that should be used by AWS Backups. The ARN should have the format `arn:aws:iam::account-id:role/role-name`. If not provided, a new IAM role will be created."
  default     = ""
  validation {
    condition     = length(var.provided_iam_role_arn) == 0 || can(regex("^arn:aws:iam::[0-9]{12}:role/.*", var.provided_iam_role_arn))
    error_message = "The provided IAM role ARN is not valid. The ARN should have the format `arn:aws:iam::account-id:role/role-name`."
  }
}

### SFTP
variable "sftp_name" {
  description = "The name of the SFTP server"
  default     = ""
}

variable "identity_provider_type" {
  description = "Identity provider type of the SFTP server"
  default     = "SERVICE_MANAGED"
}

variable "endpoint_type" {
  description = "Endpoint type of the SFTP server"
  default     = "PUBLIC"
}

variable "sftp_domain" {
  description = "Domain type of the SFTP server"
  default     = "EFS"
}

variable "home_directory" {
  description = "Home directory type of the SFTP server"
  default     = ""
}

variable "home_directory_type" {
  description = "Home directory type of the SFTP server"
  default     = "PATH"
}

variable "sftp_users" {
  type = map(object({
    home_directory = string
    uid            = number
    gid            = number
    public_key     = string
  }))
  default = {
    user1 = {
      home_directory = ""
      uid            = 1000
      gid            = 1000
      public_key     = ""
    }
  }
}