Terraform AWS Apache Static Page Docker EC2 Instance
This Terraform code repository contains the necessary configuration to deploy a Dockerized version of Apache httpd on an Amazon EC2 instance.

Features
Deploys Apache Server on an EC2 instance.
Accessible on port 80 of the EC2 instance's public IP address.
Public IP address of the EC2 instance is displayed after execution.
Prerequisites
Before running this Terraform configuration, ensure you have the following prerequisites:

AWS account with appropriate permissions.
Terraform installed on your local machine.
AWS CLI configured with your credentials.
Usage
Clone this repository to your local machine.
  git clone https://github.com/sarmadkhan96/Terraform-AWS-CA-1.git
Navigate to the directory containing the Terraform code.
  cd Terraform
Run terraform init to initialize the Terraform configuration.
Run terraform plan to review the changes that will be applied.
Run terraform apply to create the EC2 instance.
Once the execution is complete, the public IP address of the EC2 instance will be displayed.
Note: To destroy the resources created with Terraform, use the following command:
terraform destroy -auto-approve
Accessing Apache Static Page
After the EC2 instance is provisioned, you can access Apache Server Static page by navigating to the public IP address of the instance in your web browser, followed by port 80.
