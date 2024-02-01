<!-- BEGIN_TF_DOCS -->
# AWS SFTP with EFS Terraform Module

This module set up EFS with AWS Transfer Family for accessing AxeTrading server files for managed service customers.

# Connect to sftp server:

sftp -i path-to-private-key sftp-username@sftp-server-address

# Mounting instructions:

Run the following command to install the amazon-efs-utils package: sudo yum install -y amazon-efs-utils

sudo mount -t efs -o tls EFS\_ID:/ EFS\_ID

sudo chown -R ec2-user:ec2-user EFS\_ID

sudo chmod -R 755 EFS\_ID

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.mount_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_policy.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sftp_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sftp_user_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sftp_user_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sftp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_transfer_server.sftp_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_server) | resource |
| [aws_transfer_ssh_key.sftp_ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_ssh_key) | resource |
| [aws_transfer_user.sftp_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_user) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sftp_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_efs_security_group"></a> [create\_efs\_security\_group](#input\_create\_efs\_security\_group) | Determines whether to create security group for EFS Mount | `bool` | `true` | no |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Flag to create an IAM role for SFTP users | `bool` | `true` | no |
| <a name="input_create_sftp_security_group"></a> [create\_sftp\_security\_group](#input\_create\_sftp\_security\_group) | Determines whether to create security group for EFS Mount | `bool` | `true` | no |
| <a name="input_efs_name"></a> [efs\_name](#input\_efs\_name) | Efs name | `string` | `""` | no |
| <a name="input_efs_security_group_name"></a> [efs\_security\_group\_name](#input\_efs\_security\_group\_name) | Security Group Name | `string` | `""` | no |
| <a name="input_efs_security_group_rules"></a> [efs\_security\_group\_rules](#input\_efs\_security\_group\_rules) | A map of security group rule definitions to add to the security group created | `map(any)` | `{}` | no |
| <a name="input_eip_ids"></a> [eip\_ids](#input\_eip\_ids) | A list of Elastic IP IDs to associate with the SFTP server | `list(string)` | `[]` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | Whether to enable encryption for the file system. Default is true. | `bool` | `true` | no |
| <a name="input_endpoint_type"></a> [endpoint\_type](#input\_endpoint\_type) | Endpoint type of the SFTP server | `string` | `"PUBLIC"` | no |
| <a name="input_home_directory"></a> [home\_directory](#input\_home\_directory) | Home directory type of the SFTP server | `string` | `""` | no |
| <a name="input_home_directory_type"></a> [home\_directory\_type](#input\_home\_directory\_type) | Home directory type of the SFTP server | `string` | `"PATH"` | no |
| <a name="input_identity_provider_type"></a> [identity\_provider\_type](#input\_identity\_provider\_type) | Identity provider type of the SFTP server | `string` | `"SERVICE_MANAGED"` | no |
| <a name="input_is_public"></a> [is\_public](#input\_is\_public) | Determines whether the SFTP server should be publicly accessible | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to be used to protect the encrypted file system. This parameter is only required if you want to use a non-default CMK. If this parameter is not specified, the default CMK for Amazon EFS is used. This ID can be in one of the following formats: Key ID - A unique identifier of the key, for example 1234abcd-12ab-34cd-56ef-1234567890ab. ARN - An Amazon Resource Name (ARN) for the key, for example arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab. Key alias - A previously created display name for a key, for example alias/projectKey1. Key alias ARN - An ARN for a key alias, for example arn:aws:kms:us-east-2:444455556666:alias/projectKey1. If KmsKeyId is specified, the Encrypted flag must also be set. | `string` | `null` | no |
| <a name="input_logging_enabled"></a> [logging\_enabled](#input\_logging\_enabled) | Enable logging for the SFTP server - the logs will be stored in CloudWatch | `bool` | `false` | no |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | Efs performance mode | `string` | `"generalPurpose"` | no |
| <a name="input_provided_iam_role_arn"></a> [provided\_iam\_role\_arn](#input\_provided\_iam\_role\_arn) | The Amazon Resource Name (ARN) of an existing IAM role that should be used by AWS Backups. The ARN should have the format `arn:aws:iam::account-id:role/role-name`. If not provided, a new IAM role will be created. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-west-2"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of security group ids that should be attached to EFS Mount | `list(string)` | `[]` | no |
| <a name="input_security_policy_name"></a> [security\_policy\_name](#input\_security\_policy\_name) | Specifies the name of the security policy that is attached to the server. Possible values are TransferSecurityPolicy-2018-11, TransferSecurityPolicy-2020-06, and TransferSecurityPolicy-2023-05. Default value is: TransferSecurityPolicy-2023-05. | `string` | `"TransferSecurityPolicy-2023-05"` | no |
| <a name="input_sftp_domain"></a> [sftp\_domain](#input\_sftp\_domain) | Domain type of the SFTP server | `string` | `"EFS"` | no |
| <a name="input_sftp_name"></a> [sftp\_name](#input\_sftp\_name) | The name of the SFTP server | `string` | `""` | no |
| <a name="input_sftp_security_group_ids"></a> [sftp\_security\_group\_ids](#input\_sftp\_security\_group\_ids) | A list of security group ids that should be attached to the SFTP server | `list(string)` | `[]` | no |
| <a name="input_sftp_security_group_name"></a> [sftp\_security\_group\_name](#input\_sftp\_security\_group\_name) | Security Group Name | `string` | `""` | no |
| <a name="input_sftp_security_group_rules"></a> [sftp\_security\_group\_rules](#input\_sftp\_security\_group\_rules) | A map of security group rule definitions to add to the security group created | `map(any)` | `{}` | no |
| <a name="input_sftp_users"></a> [sftp\_users](#input\_sftp\_users) | A map of SFTP users to create | <pre>map(object({<br>    uid        = number<br>    gid        = number<br>    public_key = string<br>    restricted = optional(bool, false)<br>  }))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A map of subnets to availability zones | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | Efs throughput mode | `string` | `"bursting"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The name of the VPC where you want to create the resources | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_file_system_id"></a> [efs\_file\_system\_id](#output\_efs\_file\_system\_id) | EFS ID |
| <a name="output_efs_mount_target_dns_names"></a> [efs\_mount\_target\_dns\_names](#output\_efs\_mount\_target\_dns\_names) | EFS Mount targets DNS name |
| <a name="output_efs_mount_target_ids"></a> [efs\_mount\_target\_ids](#output\_efs\_mount\_target\_ids) | EFS Mount targets |
| <a name="output_efs_security_group_id"></a> [efs\_security\_group\_id](#output\_efs\_security\_group\_id) | EFS Security Group ID |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | IAM ROLE ARN used for SFTP users |
| <a name="output_sftp_elastic_ips"></a> [sftp\_elastic\_ips](#output\_sftp\_elastic\_ips) | Provisioned Elastic IPs |
| <a name="output_sftp_security_group_id"></a> [sftp\_security\_group\_id](#output\_sftp\_security\_group\_id) | SFTP Security Group ID |
| <a name="output_sftp_server_arn"></a> [sftp\_server\_arn](#output\_sftp\_server\_arn) | SFTP SERVER ARN |
| <a name="output_sftp_server_endpoint"></a> [sftp\_server\_endpoint](#output\_sftp\_server\_endpoint) | SFTP SERVER ENDPOINT |
| <a name="output_sftp_server_id"></a> [sftp\_server\_id](#output\_sftp\_server\_id) | SFTP SERVER ID |
| <a name="output_sftp_user_usernames"></a> [sftp\_user\_usernames](#output\_sftp\_user\_usernames) | SFTP SERVER USERS |
<!-- END_TF_DOCS -->
