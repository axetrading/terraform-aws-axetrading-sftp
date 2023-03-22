<!-- BEGIN_TF_DOCS -->
# AWS SFTP Terraform Module

This module set up EFS with AWS Transfer Family for accessing AxeTrading server files for managed service customers.\n
<<EOT
Connect to sftp server:
sftp -i <path-to-private-key> <username>@<server-address>

Mounting instructions:
sudo mount -t efs -o tls EFS_NAME:/ efs   # where EFS_NAME = ID of EFS
EOT


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.50 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.mount_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_iam_policy.sftp_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.sftp_user_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sftp_user_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_transfer_server.sftp_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_server) | resource |
| [aws_transfer_ssh_key.sftp_ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_ssh_key) | resource |
| [aws_transfer_user.sftp_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_user) | resource |
| [tls_private_key.sftp_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sftp_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az"></a> [az](#input\_az) | The name of the Availability Zones | `list(string)` | `[]` | no |
| <a name="input_create_sftp_server"></a> [create\_sftp\_server](#input\_create\_sftp\_server) | Flag to create an AWS Transfer Family SFTP server | `bool` | `false` | no |
| <a name="input_create_sftp_user"></a> [create\_sftp\_user](#input\_create\_sftp\_user) | Flag to create an AWS Transfer Family SFTP server | `bool` | `false` | no |
| <a name="input_efs_name"></a> [efs\_name](#input\_efs\_name) | The name of the EFS file system | `list` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-west-2"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The name of the Security Groups | <pre>list(object({<br>    id = string<br>  }))</pre> | n/a | yes |
| <a name="input_sftp_name"></a> [sftp\_name](#input\_sftp\_name) | The name of the SFTP server | `list` | `[]` | no |
| <a name="input_sftp_user_name"></a> [sftp\_user\_name](#input\_sftp\_user\_name) | The username for the SFTP user | `list` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The name of the Subnets | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The name of the VPC where you want to create the resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_file_system_arns"></a> [efs\_file\_system\_arns](#output\_efs\_file\_system\_arns) | ARN of EFS |
| <a name="output_efs_file_system_dns_names"></a> [efs\_file\_system\_dns\_names](#output\_efs\_file\_system\_dns\_names) | DNS NAME of EFS |
| <a name="output_efs_file_system_ids"></a> [efs\_file\_system\_ids](#output\_efs\_file\_system\_ids) | ID of EFS |
| <a name="output_efs_mount_target_dns_names"></a> [efs\_mount\_target\_dns\_names](#output\_efs\_mount\_target\_dns\_names) | DNS NAME of EFS Mount Target |
| <a name="output_efs_mount_target_ids"></a> [efs\_mount\_target\_ids](#output\_efs\_mount\_target\_ids) | MOUNT TARGED ID of EFS |
| <a name="output_sftp_server_id"></a> [sftp\_server\_id](#output\_sftp\_server\_id) | ID of SFTP server |
| <a name="output_sftp_user_home_directory"></a> [sftp\_user\_home\_directory](#output\_sftp\_user\_home\_directory) | HOME\_DIR for SFTP user |
| <a name="output_sftp_user_id"></a> [sftp\_user\_id](#output\_sftp\_user\_id) | ID of SFTP user |
| <a name="output_sftp_user_key"></a> [sftp\_user\_key](#output\_sftp\_user\_key) | SSH Private Key for SFTP User |
| <a name="output_sftp_user_name"></a> [sftp\_user\_name](#output\_sftp\_user\_name) | NAME of SFTP user |
<!-- END_TF_DOCS -->