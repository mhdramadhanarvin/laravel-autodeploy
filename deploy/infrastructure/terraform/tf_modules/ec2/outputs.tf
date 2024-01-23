output "ami_id" {
  value = data.aws_ami.ubuntu_2204.id
}

output "public_dns" {
  value = aws_instance.server.public_dns
}

output "public_ip" {
  value = aws_instance.server.public_ip
}

output "ssh_user" {
  value = var.ssh_user
}

output "ansible_script" {
  value = var.ansible_script
}
