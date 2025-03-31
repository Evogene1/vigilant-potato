# vigilant-potato

# AWS Infrastructure Deployment with Terraform
### Overview
This project provides an automated deployment of an AWS infrastructure using Terraform. The configuration includes:
1.  A Virtual Private Cloud (VPC)
2.	Public and private subnets
3.	Internet Gateway
4.	Route tables for public and private subnets
5.	Security Groups for EC2, RDS, and Redis
6.	A MySQL RDS instance
7.	An ElastiCache Redis instance
8.	An EC2 instance running a Go API application with Docker and WordPress
   
### Prerequisites
Before deploying the infrastructure, ensure that you have:

1.	Terraform Installed - Download Terraform
2.	AWS Account - Free Tier can be used
3.	AWS CLI Installed - AWS CLI Installation
4.	IAM User with Required Permissions - The user should have full access to:
EC2, RDS, ElastiCache, VPC, Security Groups, IAM

## Configuration Options
### Variables

The variables.tf file contains the customizable variables for this Terraform module. Below are key variables you may need to adjust:

The following variables can be customized for your deployment:

| Variable              | Description                        | Default Value  |
|-----------------------|------------------------------------|----------------|
| `REGION`              | AWS Region                         | `eu-west-1`    |
| `ZONE1`               | Availability Zone 1                | `eu-west-1a`   |
| `ZONE2`               | Availability Zone 2                | `eu-west-1b`   |
| `vpc_cidr`            | CIDR block for the VPC             | `10.0.0.0/16`  |
| `subnet_cidr_public`  | CIDR block for Public Subnet       | `10.0.0.0/24`  |
| `subnet_cidr_private1`| CIDR block for Private Subnet 1    | `10.0.1.0/24`  |
| `subnet_cidr_private2`| CIDR block for Private Subnet 2    | `10.0.2.0/24`  |
| `rds_user`            | RDS master username                | `your_user`    |
| `rds_passwd`          | RDS master password                | `your_password`|
| `db_name`             | Database name                      | `your_db_name` |
| `access_key`          | AWS Access Key                     | `*`            |
| `secret_key`          | AWS Secret Key                     | `*`            |

You can override these variables in a terraform.tfvars file or pass them as command-line arguments.
Customizing Security Groups
-   Modify the aws_security_group_rule resources to restrict access.
-	By default, SSH (port 22) and HTTP (port 80) are open to all (0.0.0.0/0).
-	The RDS and Redis security groups allow internal VPC access only.





## Deployment Steps
1. Initialize Terraform
```
terraform init
```
2. Plan the Deployment
```
terraform plan
```
3. Apply the Configuration
```
terraform apply
```
4. Destroy the Infrastructure (If Needed)
```
terraform destroy
```

## Troubleshooting & Common Issues
### Issue: "InvalidClientTokenId"
Solution: Ensure your AWS credentials are correctly configured using aws configure.
### Issue: "Error: Instance Type Not Available"
Solution: Change the instance_type in the aws_instance resource to an available type (e.g., t3.micro).
### Issue: "Permission Denied (Public Key)" While Connecting via SSH
Solution: Ensure you are using the correct SSH key specified in var.PUB_KEY.
### Issue: "RDS Instance Creation Fails"
Solution:
1.	Check multi_az = true in aws_db_instance (not available in Free Tier; set to false if needed).
2.	Ensure allocated_storage = 20 (minimum required by some regions for MySQL).

Next Steps
-	Integrate Terraform with CI/CD for automated infrastructure management.
-	Implement Terraform remote state with S3 and DynamoDB.
-	Improve security by using AWS Secrets Manager for storing sensitive credentials.


