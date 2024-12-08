
## Infrastructure Overview

- VPC with 2 public and 2 private subnets across different Availability Zones
- Internet Gateway for public internet access
- NAT Gateway for private subnets to access the internet
- Route tables for both public and private subnets
- Security Groups and Network ACLs for enhanced security
- Bastion host for secure access to private subnets

## Usage

1. Clone this repository:
   ```
   git clone https://github.com/dadashussein/rsschool-devops-course-tasks
   cd rsschool-devops-course-tasks
   ```

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Review the planned changes:
   ```
   terraform plan
   ```

4. Apply the Terraform configuration:
   ```
   terraform apply
   ```

5. When prompted, type `yes` to confirm the creation of resources.

## Accessing Private Instances

To access instances in the private subnets:

1. Connect to the bastion host using SSH:
   ```
   ssh -i yourpem ec2-user@<bastion-host-public-ip>
   ```

2. From the bastion host, connect to private instances:
   ```
   ssh -i yourpem ec2-user@<private-instance-ip>
   ```

## Cleaning Up

To destroy the created infrastructure:


## Security Considerations

- The bastion host is the only entry point to the private subnets.
- Security Groups and Network ACLs are implemented to control inbound and outbound traffic.
- NAT Gateway allows private instances to access the internet while remaining private.


## Continuous Integration

This project uses GitHub Actions for continuous integration. The pipeline runs `terraform fmt`, `terraform init`, and `terraform plan` on every push to the main branch.
