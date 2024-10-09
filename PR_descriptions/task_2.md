# Task 2 - Pull Request description
1. Task: [CLICK ME](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/1_basic-configuration/task_2.md)
2. Screenshots (if needed): Check ./screenshots/ folder
3. Code: [CLICK ME](https://github.com/lexxnsk/rsschool-devops-course-tasks/tree/task2)
4. Done 2024-10-11 11:11 / deadline 2024-10-14 01:59
5. Score: 100 / 100
###### Evaluation Criteria (100 points for covering all criteria)

1. **[+] Terraform Code Implementation (50 points)**

   - [+] Terraform code is created to configure the following:
     - [+] VPC
     - [+] 2 public subnets in different AZs - ["10.0.0.0/24", "10.0.1.0/24"]
     - [+] 2 private subnets in different AZs - ["10.0.2.0/24", "10.0.3.0/24"]
     - [+] Internet Gateway
     - [+] Routing configuration:
       - [+] Instances in all subnets can reach each other
       - [+] Instances in public subnets can reach addresses outside VPC and vice-versa
```
Outputs:

aws_region = "eu-central-1"
bastion_host_private_ip = "10.0.0.209"
bastion_host_public_ip = "3.123.42.140"
dummy_host_private_ip = "10.0.2.240"
dummy_host_public_ip = ""
private_keyyyyyy = <sensitive>
amyslivets@MacBook-Air-Alex rsschool-devops-course-tasks %
amyslivets@MacBook-Air-Alex rsschool-devops-course-tasks %
amyslivets@MacBook-Air-Alex rsschool-devops-course-tasks % ssh -i my_key.pem ec2-user@3.123.42.140                              
Last login: Tue Oct  8 21:12:01 2024 from 178235183183.dynamic-4-waw-k-4-3-0.vectranet.pl
   ,     #_
   ~\_  ####_        Amazon Linux 2
  ~~  \_#####\
  ~~     \###|       AL2 End of Life is 2025-06-30.
  ~~       \#/ ___
   ~~       V~' '->
    ~~~         /    A newer version of Amazon Linux is available!
      ~~._.   _/
         _/ _/       Amazon Linux 2023, GA and supported until 2028-03-15.
       _/m/'           https://aws.amazon.com/linux/amazon-linux-2023/

[ec2-user@ip-10-0-0-209 ~]$ ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9001
        inet 10.0.0.209  netmask 255.255.255.0  broadcast 10.0.0.255
        inet6 fe80::98:f7ff:fe09:d861  prefixlen 64  scopeid 0x20<link>
        ether 02:98:f7:09:d8:61  txqueuelen 1000  (Ethernet)
        RX packets 96305  bytes 113832720 (108.5 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 33186  bytes 3644076 (3.4 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 48  bytes 3888 (3.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 48  bytes 3888 (3.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

[ec2-user@ip-10-0-0-209 ~]$ ping 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=57 time=1.52 ms
64 bytes from .1.1.1: icmp_seq=2 ttl=57 time=1.19 ms
^C
--- 1.1.1.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 1.194/1.359/1.525/0.169 ms
[ec2-user@ip-10-0-0-209 ~]$ ping 10.0.2.240
PING 10.0.2.240 (10.0.2.240) 56(84) bytes of data.
64 bytes from 10.0.2.240: icmp_seq=1 ttl=255 time=1.10 ms
64 bytes from 10.0.2.240: icmp_seq=2 ttl=255 time=0.801 ms
^C
--- 10.0.2.240 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 3007ms
rtt min/avg/max/mdev = 0.708/1.102/1.794/0.426 ms
[ec2-user@ip-10-0-0-209 ~]$
[ec2-user@ip-10-0-0-209 ~]$
[ec2-user@ip-10-0-0-209 ~]$ ssh -i my_key.pem ec2-user@10.0.2.240
Last login: Tue Oct  8 21:12:03 2024 from 10.0.0.209
   ,     #_
   ~\_  ####_        Amazon Linux 2
  ~~  \_#####\
  ~~     \###|       AL2 End of Life is 2025-06-30.
  ~~       \#/ ___
   ~~       V~' '->
    ~~~         /    A newer version of Amazon Linux is available!
      ~~._.   _/
         _/ _/       Amazon Linux 2023, GA and supported until 2028-03-15.
       _/m/'           https://aws.amazon.com/linux/amazon-linux-2023/

[ec2-user@ip-10-0-2-240 ~]$ ping 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=56 time=3.15 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=56 time=2.29 ms
ć64 bytes from 1.1.1.1: icmp_seq=3 ttl=56 time=1.91 ms
64 bytes from 1.1.1.1: icmp_seq=4 ttl=56 time=1.89 ms
^C
--- 1.1.1.1 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3003ms
rtt min/avg/max/mdev = 1.894/2.315/3.151/0.509 ms
[ec2-user@ip-10-0-2-240 ~]$ ping 10.0.0.209
PING 10.0.0.209 (10.0.0.209) 56(84) bytes of data.
64 bytes from 10.0.0.209: icmp_seq=1 ttl=255 time=0.526 ms
64 bytes from 10.0.0.209: icmp_seq=2 ttl=255 time=1.26 ms
^C
--- 10.0.0.209 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1010ms
rtt min/avg/max/mdev = 0.526/0.893/1.260/0.367 ms
[ec2-user@ip-10-0-2-240 ~]$ 
```
2. **[+] Code Organization (10 points)**

   - [+] Variables are defined in a separate variables file.
   - [+] Resources are separated into different files for better organization.

3. **[+] Verification (10 points)**

   - [+] Terraform plan is executed successfully.
   - [+] A resource map screenshot is provided (VPC -> Your VPCs -> your_VPC_name -> Resource map).

4. **[+] Additional Tasks (30 points)**
   - **[+] Security Groups and Network ACLs (5 points)**
     - [+] Implement security groups and network ACLs for the VPC and subnets.
   - **[+] Bastion Host (5 points)**
     - [+] Create a bastion host for secure access to the private subnets.
   - **[+] NAT is implemented for private subnets (10 points)**
     - [+] Orginize NAT for private subnets with simpler or cheaper way
     - [+] Instances in private subnets should be able to reach addresses outside VPC
   - **[+] Documentation (5 points)**
     - Document the infrastructure setup and usage in a README file.
   - **[+] Submission (5 points)**
   - [+] A GitHub Actions (GHA) pipeline is set up for the Terraform code: [CLICK ME](https://github.com/lexxnsk/rsschool-devops-course-tasks/actions/workflows/terraform-deployment.yml)