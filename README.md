# MaxDamage81_infra
MaxDamage81 Infra repository

#HomeWork 3 Part 1

Using jumphost:
```
ssh -i ~/.ssh/appuser -J appuser@158.160.47.187 appuser@10.128.0.30
```

Using ssh config file:

```
Host  someinternalhost
    HostName 10.128.0.30
    User appuser
    ProxyJump appuser@bastion

Host bastion
    HostName 158.160.47.187
    User appuser
```

Then just type:
```
ssh someinternalhost
```

#Homework 3 Part 2

Setting up openvpn server and client

```
bastion_IP = 158.160.47.187
someinternalhost_IP = 10.128.0.30
```

Receving cert with nip.io was unsuccess with reason:
```
Error creating new order :: too many certificates already issued for \"nip.io\". Retry after 2023-08-20T17:00:00Z: see https://letsencrypt.org/docs/rate-limits/
```
Use a sslip.io:

bastion.158.160.47.187.sslip.io

#HOMEWORK 4

Deploy a testapp with cloud-init script

```
testapp_IP = 158.160.41.234
testapp_port = 9292
```
Command to run preinstalled instance:
```
yc compute instance create \
   --name reddit-app \
   --hostname reddit-app \
   --core-fraction=20 \
   --memory=4 \
   --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
   --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
   --metadata-from-file='user-data=cloud-init.yaml'
```
#HOMEWORK 5

Install and configure packer
Create pkr.hcl & json config files
Create and configure variables files
Create autodeploy template and YC script

How to run:
```
packer build -var-file=./variables.pkr.hcl ./immutable.pkr.hcl
```
```
./create-reddit-vm.sh
```
#HOMEWORK 6
-
-Install and configure terraform
-Create service account for terraform
-Create main.tf file with instance data
-Create tfvars file for variables
-
--Advanced tasks:
-Create lb.tf file with LB data
-Edit output.tf file for comfortable output IPs
-Check result (trying stop puma on one of instance) - OK

#HOMEWORK 7

- Create new packer image
- Create APP and DB modules
- Create stage and prod env.

Advanced tasks:
- Create S3 storage
- Configure backend to S3
- Check tfstate file in S3 storage

#HOMEWORK 8

- intall and configure ansible
- clone reddit repo
- command "ansible app -m command -a 'rm -rf ~/reddit'" is removed git dirrectory ; Playbook "clone.yml" create clone reddit repo again
Advanced tasks:
- create dynamic inventory file (dynamicinv.sh)
- configure ansible to work with him
