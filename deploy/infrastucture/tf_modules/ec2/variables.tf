
variable "instance_name" {
  description = "Name of EC2 Instance"
}

variable "instance_type" {
  description = "Instance type"
}

variable "security_group_id" {
  description = "Security group id"
}

variable "common_tags" {
  description = "Common tags"
}

variable "public_key_name" {
  description = "Add public key to ack our SSH connection"
}

variable "private_key_path" {
  description = "Secret key to access via SSH connection"
}

data "aws_ami" "ubuntu_2204" {
  # Filter to dynamically get AMI id in different region
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }

  filter {
    name   = "owner-id"
    values = ["099720109477"] # Canonical official
  }
}

variable "ssh_user" {
  description = "User for login via SSH"
  default     = "ubuntu"
}

variable "ansible_script" {
  description = "Ansible script to run configuration"
}
