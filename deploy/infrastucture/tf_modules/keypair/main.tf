variable "key_name" {
  description = "Key name in AWS"
}

variable "public_key_path" {
  description = "Add public key to ack our SSH connection"
}

variable "common_tags" {
  description = "Common tags"
}

resource "aws_key_pair" "public" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)

  tags = var.common_tags
}

output "public_key_name" {
  value = aws_key_pair.public.key_name
}
