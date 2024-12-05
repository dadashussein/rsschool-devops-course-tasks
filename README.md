# AWS Infrastructure Setup

This repository contains Terraform configurations for setting up AWS resources, specifically an S3 bucket for storing Terraform state.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- An AWS account with appropriate permissions to create resources.


## Configuration Files

- **`variables.tf`**: Contains variable definitions for the AWS region, S3 bucket name, and tags.
- **`main.tf`**: Configures the AWS provider.
- **`s3.tf`**: Defines the S3 bucket resource.

## Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/dadashussein/rsschool-devops-course-tasks.git
   cd rsschool-devops-course-tasks
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Plan the deployment**:
   ```bash
   terraform plan
   ```

4. **Apply the configuration**:
   ```bash
   terraform apply
   ```

## Notes

- Ensure your AWS credentials are configured properly. You can set them using the AWS CLI or environment variables.
- Modify the `variables.tf` file to customize the region, bucket name, and tags as needed.

