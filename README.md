# The RS School - AWS DevOps Course. Project Documentation.

This repository contains the Terraform configuration files used for provisioning and managing infrastructure. The following document explains the structure and purpose of each file and directory in the project.

## File Structure
```
├── .github/workflows/
├── PR_descriptions/
├── screenshots/
├── .gitignore
├── README.md
├── ec2.tf
├── igw.tf
├── main.tf
├── nacl.tf
├── nat.tf
├── outputs.tf
├── providers.tf
├── resources.tf
├── route_tables.tf
├── security_groups.tf
├── subnets.tf
├── variables.tf
├── vpc.tf
```

### Directory & File Overview

- **```.github/workflows/```**:  
  This directory is a special folder in a GitHub repository that contains YAML files defining GitHub Actions workflows. 
- **```PR_descriptions/```**:  
  This directory contains the descriptions for Pull Request.
- **```screenshots/```**:  
  This directory contains screenshots and texts that verify the correct configuration of AWS accounts and installed software versions.
- **```.gitignore```**:  
  This file specifies which files or directories should be ignored by Git when tracking changes in a repository.
- **```README.md```**:  
  This file in GitHub serves as the primary documentation for a repository (you're reading it right now).
- **```ec2.tf```**:  
  This file defines resources related to EC2 instances.
- **```igw.tf```**:  
  This file defines resources related to the Internet Gateway (IGW).
- **```main.tf```**:  
  The main configuration file where the core infrastructure is defined. This typically includes high-level resources such as modules, remote backends, and resource declarations.
- **```nacl.tf```**:  
  This file defines Network Access Control Lists (NACLs), which act as a firewall for controlling inbound and outbound traffic at the subnet level.
- **```nat.tf```**:  
  This file defines resources related to the Network Address Translation (NAT) Gateway.
- **```outputs.tf```**:  
  This file contains the output definitions for the Terraform resources. Outputs are used to display important information after the Terraform configuration has been applied.
- **```providers.tf```**:  
  This file specifies the providers required by the project (e.g., AWS, Google Cloud). Providers are responsible for defining resources and interacting with APIs.
- **```resources.tf```**:  
  This file contains the specific resource declarations that will be managed by Terraform. Resources can include ec2 instances, databases, networking components, IAM roles and more.
- **```route_tables.tf```**:  
  This file defines resources related to route tables. Route tables determine how traffic is directed within the VPC.
- **```security_groups.tf```**:  
  This file defines Security Groups, which control the inbound and outbound traffic at the instance level.
- **```subnets.tf```**:  
  This file defines the subnets in the VPC. 
- **```variables.tf```**:  
  This file defines the input variables for the Terraform project. This includes variable types, default values, and descriptions, which allow users to customize the deployment.
- **```vpc.tf```**:  
  This file defines the Virtual Private Cloud (VPC) and related core networking components, such as the CIDR block, tags, and the overall network structure for resources within the VPC.

### GitHub variables and GitHub Secrets variables
 1. The IAM role variable ```TERRAFORM_GITHUB_ACTIONS_ROLE_NAME``` and the Terraform version variable ```TERRAFORM_VERSION``` are stored in GitHub Variables. They were created using the following commands:  
```gh variable set TERRAFORM_GITHUB_ACTIONS_ROLE_NAME --body "GithubActionsRole" --repo lexxnsk/rsschool-devops-course-tasks```  
```gh variable set TERRAFORM_VERSION --body "1.9.6" --repo lexxnsk/rsschool-devops-course-tasks```  
You can list it using the following command:  
```gh variable list --repo lexxnsk/rsschool-devops-course-tasks```  
2. AWS Account ID variable ```aws_account_id``` is stored in GitHub Secrets. It was created using the following command:  
```gh secret set AWS_ACCOUNT_ID --body "<AWS_ACCOUNT_ID>" --repo lexxnsk/rsschool-devops-course-tasks```  
You can list it using the following command:  
```gh secret list --repo lexxnsk/rsschool-devops-course-tasks```  

---
**NOTE:**
The AWS Account ID variable ```aws_account_id``` should be in lowercase. This is essential because Terraform is case-sensitive and requires consistency in variable naming.

---

## How to Use it manually:

1. **Initialize Terraform:**  
   Before using the configuration, comment terraform backend configuration in ```main.tf``` and initialize Terraform by running:
   ```terraform init```
2. **Plan and Apply Changes:**  
   Review changes by running:
   ```terraform plan -var="aws_account_id=XXXXXXXXXXXX"```  
   Apply changes by running:
   ```terraform apply -var="aws_account_id=XXXXXXXXXXXX"```
3. **Migrate Terraform S3 backend to S3:**  
   Uncomment terraform backend configuration in ```main.tf``` and initialize Terraform by running:  
   ```terraform init```
4. **Plan and Apply Changes:** 
   Review changes by running:
   ```terraform plan -var="aws_account_id=XXXXXXXXXXXX"```  
   Apply changes by running:
   ```terraform apply -var="aws_account_id=XXXXXXXXXXXX"```
5. **Now you have up and running Terraform using S3 bucket and Dynamo DB as a backend + the all the infrastructure**  

---

## How to Use it automatically:
1. **GitHub Actions:**  
   Before committing, check the ```.github/workflows/terraform-deployment.yml``` file and update the branch name to trigger the GitHub workflow automatically.​⬤