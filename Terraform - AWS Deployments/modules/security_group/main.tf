# ------------------------------------------------------------------------------
# AWS S3 Bucket module
# ------------------------------------------------------------------------------

// Security Group
resource "aws_security_group" "sg" {
  #count = var.create_sg ? 1 : 0

  name        = "My_sg"
  description = "Allow ingress traffic for ssh and http"
  vpc_id      = var.vpcid

dynamic "ingress" {
  for_each = var.inbound_ports
  content {
    from_port = ingress.value
    to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  } 
}
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "Allow ssh and http connections"
  }
}