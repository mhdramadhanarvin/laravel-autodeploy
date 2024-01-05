## Context

This project will be deploy to AWS EC2 with container, specific will use docker swarm 

- Terraform for provision aws ec2 
  - Security group
  - Keypair
  - EC2 Instance
- Ansible for setup requirement  
  - Insallation package. e.g : docker
  - Install docker swarm
- Ansible for deploy 
  - Build docker image 
  - Push docker image into Github Package Registry
  - Update docker swarm stack to use new image

