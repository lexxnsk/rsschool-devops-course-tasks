# Task 3 - Pull Request description
1. Task: [CLICK ME](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/2_cluster-configuration/task_3.md)
2. Screenshots (if needed): Check ./screenshots/ folder
3. Code: [CLICK ME](https://github.com/lexxnsk/rsschool-devops-course-tasks/tree/task_3)
4. Done 2024-10-20 17:00 / deadline 2024-10-21 02:59
5. Score: 100 / 100
###### Evaluation Criteria (100 points for covering all criteria)

1. **Terraform Code for AWS Resources (10 points)**

   - [+] Terraform code is created or extended to manage AWS resources required for the cluster creation.
   - [+] The code includes the creation of a bastion host.

2. **Cluster Deployment (60 points)**

   - [+] A K8s cluster is deployed using either kOps or k3s.
   - [+] The deployment method is chosen based on the user's preference and understanding of the trade-offs.

3. **Cluster Verification (10 points)**

   - [+] The cluster is verified by running the `kubectl get nodes` command from the local computer.
   - [+] A screenshot of the `kubectl get nodes` command output is provided.
```
ec2-user@ip-10-0-2-20:~> sudo /usr/local/bin/k3s kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
ip-10-0-2-20   Ready    control-plane,master   11m   v1.30.5+k3s1
ip-10-0-3-57   Ready    <none>                 10m   v1.30.5+k3s1
ec2-user@ip-10-0-2-20:~> sudo /usr/local/bin/k3s kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          8m12s
```
4. **Workload Deployment (10 points)**

   - [+] A simple workload is deployed on the cluster using `kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml`.
   - [+] The workload runs successfully on the cluster.

5. **Additional Tasks (10 points)**
   - [+] Document the cluster setup and deployment process in a README file.