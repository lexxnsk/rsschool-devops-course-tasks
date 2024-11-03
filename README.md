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
├── jenkins-sa.yaml
├── jenkins-values.yaml
├── jenkins-volume.yaml
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
  This directory contains necessary screenshots and texts.
- **```.gitignore```**:  
  This file specifies which files or directories should be ignored by Git when tracking changes in a repository.
- **```README.md```**:  
  This file in GitHub serves as the primary documentation for a repository (you're reading it right now).
- **```ec2.tf```**:  
  This file defines resources related to EC2 instances.
- **```igw.tf```**:  
  This file defines resources related to the Internet Gateway (IGW).
- **```jenkins-sa.yaml```**:  
  This file contains the configuration for a Service Account in a K3S cluster that is specifically used for Jenkins.
- **```jenkins-values.yaml```**:  
  This file contains configuration values that customize the deployment of Jenkins within a K3S cluster.
- **```jenkins-volume.yaml```**:  
  This file contains configuration to define persistent storage for Jenkins in a K3S environment.
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
 1. **The IAM role variable** ```TERRAFORM_GITHUB_ACTIONS_ROLE_NAME``` and the Terraform version variable ```TERRAFORM_VERSION``` are stored in GitHub Variables. They were created using the following commands:  
```gh variable set TERRAFORM_GITHUB_ACTIONS_ROLE_NAME --body "GithubActionsRole" --repo lexxnsk/rsschool-devops-course-tasks```  
```gh variable set TERRAFORM_VERSION --body "1.9.6" --repo lexxnsk/rsschool-devops-course-tasks```  
2. **AWS Account ID variable** ```aws_account_id``` is stored in GitHub Secrets. It was created using the following command:  
```gh secret set AWS_ACCOUNT_ID --body "<AWS_ACCOUNT_ID>" --repo lexxnsk/rsschool-devops-course-tasks```  
3. **K3S token variable** ```K3S_TOKEN``` is stored in GitHub Secrets. It was created using the following command:  
```gh secret set K3S_TOKEN --body "<K3S_TOKEN>" --repo lexxnsk/rsschool-devops-course-tasks```  

You can list variables and secrets using the following commands:  
```gh variable list --repo lexxnsk/rsschool-devops-course-tasks```  
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


---
## Task 3 clarifications:
**K3S token variable is stored in GitHub Secrets.** 
You can list it using this command:  
```gh secret list --repo lexxnsk/rsschool-devops-course-tasks```

**Connection to the K3S Server node from your laptop via Bastion Host:**
- Add your private SSH key (in this case, aws.pem) to the SSH authentication agent:  
```ssh-add aws.pem```
- Check it:  
```ssh-add -l```  
- Connect to the K3S Server node from your laptop via Bastion Host:  
```ssh -A -J ec2-user@<PUBLIC_BASTION_IP>  ec2-user@<PRIVATE_K3S_SERVER_NODE_IP> 6443:localhost:6443```

**K3S installation consists of 1 node:**  
You can check its status by:  
```
kubectl get nodes  
kubectl get pods
kubectl describe pods
kubectl get services
```

**Connection to the K3S Server node from your laptop using port forwarding:**
- [Install](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/) KubeCTL binary locally on your laptop]
- Setup ssh port forwarding to your local machine:
```ssh -A -J ec2-user@3.127.174.1 ec2-user@10.0.2.106 -L 6443:localhost:6443```
- Check if it works using curl:
```
curl -k https://localhost:6443/                          
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "Unauthorized",
  "reason": "Unauthorized",
  "code": 401
}%
``` 
- Copy content of a file ```/etc/rancher/k3s/k3s.yaml``` from K3S server node to your laptop
- Change permissions to prevent annoying warnings by ```chmod 600 /Users/amyslivets/Documents/AWS/k3s.yml```
- Export path to this local file to a variable and check it:
```
export KUBECONFIG=/Users/amyslivets/Documents/AWS/k3s.yml
echo $KUBECONFIG                                         
/Users/amyslivets/Documents/AWS/k3s.yml
```
- Now kubectl should work locally from your laptop:
```
amyslivets@MacBook-Air-Alex rsschool-devops-course-tasks % kubectl get nodes
NAME            STATUS   ROLES                  AGE   VERSION
ip-10-0-2-106   Ready    control-plane,master   19m   v1.30.6+k3s1
```

App deployment is done by executing:  
```kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml```


---
## Task 4 clarifications:
**K3S preparation:**
- You can change default K3S namespace by:
```kubectl config set-context --current --namespace=jenkins```
- You can install Jenkins using next commands:
```
helm repo add jenkins https://charts.jenkins.io
helm repo update
kubectl apply -f jenkins-volume.yaml
kubectl create namespace jenkins
kubectl apply -f jenkins-sa.yaml    
chart=jenkinsci/jenkins
helm install jenkins -n jenkins -f jenkins-values.yaml $chart
```
- You can describe pod and then check init container logs for debug:
```kubectl logs jenkins-0 -c init``` 
```kubectl describe pod jenkins-0```
- You can check current pods status and check persistency by:
```
kubectl get pods
kubectl delete pod jenkins-0
kubectl get pods
```
- You can check service by:
```
kubectl get svc jenkins -n jenkins
NAME      TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
jenkins   NodePort   10.43.125.237   <none>        8080:32000/TCP   27m
```
- You can check current K3s storage class using this command:  
```
kubectl get storageclass
NAME                   PROVISIONER                    RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
jenkins-pv             kubernetes.io/no-provisioner   Delete          WaitForFirstConsumer   false                  56m
local-path (default)   rancher.io/local-path          Delete          WaitForFirstConsumer   false                  62m
```
- Here is a simple NGINX reverse proxy config to be installed on Bastion Host:
```
sudo vi /etc/nginx/conf.d/jenkins.conf

server {
    listen 80;
    server_name jenkins.myslivets.ru;

    location / {
        proxy_pass http://10.0.2.10:32000;       # Forward requests to Jenkins
        proxy_http_version 1.1;                  # Use HTTP/1.1 for proxying
        proxy_set_header Upgrade $http_upgrade;  # Handle WebSocket connections
        proxy_set_header Connection 'upgrade';   # Handle WebSocket connections
        proxy_set_header Host $host;             # Preserve original Host header
        proxy_set_header X-Real-IP $remote_addr; # Pass the client IP address
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; # Preserve client IP
        proxy_set_header X-Forwarded-Proto $scheme; # Preserve protocol (http or https)
    }
}

chmod 600 /Users/amyslivets/Documents/AWS/k3s.yml
sudo nginx -t
sudo systemctl restart nginx
``` 
- You can simulate Jenkins on Server Node by running a simple Python Server:
```
sudo python3 -m http.server 32000
```
