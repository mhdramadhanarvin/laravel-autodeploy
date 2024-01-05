variable "sg_name" {
  description = "Security Group Name"
}

variable "common_tags" {
  description = "Common tags"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "sg" {
  name   = var.sg_name
  vpc_id = data.aws_vpc.default.id
  tags   = var.common_tags

  ingress {
    description = "HTTP Port"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP(s) Port"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH connection"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1" # all protocol
    from_port   = 0    # all port
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"] # from all port
  }
}

output "sg_id" {
  value = aws_security_group.sg.id
}
