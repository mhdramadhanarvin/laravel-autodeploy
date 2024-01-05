###################
# Input 
###################

variable "region" {
  default = "ap-southeast-3"
}

locals {
  common_tags = {
    Project   = "Laravel Autodeploy"
    Contact   = "mramadhan687@gmail.com"
    ManagedBy = "Terraform"
    Version   = "1.2.8"
  }
}

variable "public_key_path" {
  description = "Add public key to ack our SSH connection"
  default     = "~/.ssh/laravel-autodeploy.pub"
}

variable "private_key_path" {
  description = "Secret key to access via SSH connection"
  default     = "~/.ssh/laravel-autodeploy"
}

###################
# Output 
###################

output "public-dns" {
  value = module.ec2_instance.public_dns
}

output "public-ip" {
  value = module.ec2_instance.public_ip
}

output "ansible-to-server" {
  value = {
    ansible-to-server = join(
      "",
      [
        "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ",
        "-u ${module.ec2_instance.ssh_user} ",
        "-i ${module.ec2_instance.public_dns}, ",
        " --private-key ${var.private_key_path} ",
        "${module.ec2_instance.ansible_script} "
      ]
    ),
  }
}
