# The RS School - AWS DevOps Course. Project Documentation.

This repository contains the Terraform configuration files used for provisioning and managing infrastructure. The following document explains the structure and purpose of each file and directory in the project.

## File Structure
```
├── .github/workflows/
├── screenshots/
├── .gitignore
├── README.md
├── main.tf
├── outputs.tf
├── providers.tf
├── resources.tf
├── variables.tf
```

### Directory & File Overview

- **```.github/workflows/```**:  
  This directory is a special folder in a GitHub repository that contains YAML files defining GitHub Actions workflows. 
- **```screenshots/```**:  
  This directory contains screenshots that verify the correct configuration of AWS accounts and installed software versions.
- **```.gitignore```**:  
  This file specifies which files or directories should be ignored by Git when tracking changes in a repository.
- **```README.md```**:  
  This file in GitHub serves as the primary documentation for a repository (you're reading it right now).
- **```main.tf```**:  
  The main configuration file where the core infrastructure is defined. This typically includes high-level resources such as modules, remote backends, and resource declarations.
- **```outputs.tf```**:  
  This file contains the output definitions for the Terraform resources. Outputs are used to display important information after the Terraform configuration has been applied.
- **```providers.tf```**:  
  This file specifies the providers required by the project (e.g., AWS, Google Cloud). Providers are responsible for defining resources and interacting with APIs.
- **```resources.tf```**:  
  This file contains the specific resource declarations that will be managed by Terraform. Resources can include ec2 instances, databases, networking components, IAM roles and more.
- **```variables.tf```**:  
  This file defines the input variables for the Terraform project. This includes variable types, default values, and descriptions, which allow users to customize the deployment.

### GitHub variables and GitHub Secrets variables
 1. IAM role variable ```TERRAFORM_GITHUB_ACTIONS_ROLE_NAME``` is stored in GitHub Variables. It was created using this command:
```gh variable set TERRAFORM_GITHUB_ACTIONS_ROLE_NAME --body "GithubActionsRole" --repo lexxnsk/rsschool-devops-course-tasks```
You can list it using this command:
```gh variable list --repo lexxnsk/rsschool-devops-course-tasks```
2. AWS Account ID variable ```aws_account_id``` is stored in GitHub Secrets. It was created using this command:
```gh secret set AWS_ACCOUNT_ID --body "<AWS_ACCOUNT_ID>" --repo lexxnsk/rsschool-devops-course-tasks```
You can list it using this command:
```gh secret list --repo lexxnsk/rsschool-devops-course-tasks```

---
**NOTE**
AWS Account ID variable ```aws_account_id``` should be in lowercase, because it is used by Terraform, which is case sensitive.

---

## How to Use

1. **Initialize Terraform:**  
   Before using the configuration, comment terraform backend configuration in ```main.tf``` and initialize Terraform by running:
   ```terraform init```
2. **Plan and Apply Changes:**  
   Review changes by running:
   ```terraform plan```  
   Apply changes by running:
   ```terraform apply```
3. **Migrate Terraform S3 backend to S3:**  
   Uncomment terraform backend configuration in ```main.tf``` and initialize Terraform by running:  
   ```terraform init```
4. **Plan and Apply Changes:**  
   Review changes by running:
   ```terraform plan```  
   Apply changes by running:
   ```terraform apply```
5. **Now you have up and running Terraform using S3 bucket and Dynamo DB as a backend**:  
