resource "aws_instance" "server" {
  # ami           = data.aws_ami.ubuntu_2204.id
  # Pin ami down to prevent reprovisioning
  ami                    = "ami-0f25be79a9ebbe821"
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]

  key_name = var.public_key_name

  tags = merge(
    var.common_tags,
    tomap({
      "Name" = "${var.common_tags.Project}-${var.instance_name}"
    })
  )

  provisioner "remote-exec" {
    # Test if the server already initialize
    inline = ["echo Done!"]

    connection {
      host        = aws_instance.server.public_dns
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
    }
  }

  provisioner "local-exec" {
    # Run this after remote-exec success
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} -i ${aws_instance.server.public_dns}, --private-key ${var.private_key_path} ${var.ansible_script}"
  }

}

