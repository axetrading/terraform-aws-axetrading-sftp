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
  type        = map(string)
  default     = {}
}


variable "azs" {
  description = "The names of the availability zones to use for the EFS mount targets"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "security_groups" {
  description = "The name of the Security Groups"
  type        = list(string)
  default     = []
}


### EFS
variable "efs_name" {
  type        = string
  description = "Efs name"
  default     = ""
}

variable "efs_tags" {
  type = map(any)
  default = {
    Name        = null
    Backup      = null
    Environment = null
    Project     = null
  }
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

variable "home_directory_type" {
  description = "Home directory type of the SFTP server"
  default     = "LOGICAL"
}

variable "sftp_users" {
  type = map(object({
    home_directory = string
    uid            = number
    gid            = number
    role_arn       = string
    public_key     = string
  }))
  default = {
    user1 = {
      home_directory = ""
      uid            = 1000
      gid            = 1000
      role_arn       = ""
      public_key     = ""
    }
  }
}