### SECURITY GROUPS

resource "aws_security_group" "default" {
  name        = "VM Traffic -  ${var.tl_short_name}"
  description = "VM Traffic -  ${var.tl_short_name}"
  vpc_id      = var.vpc

  ingress {
    description = "(Ingress)22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #checkov:skip=CKV_AWS_24:Port 22 is open and available for me to connect
  }

  egress {
    description = "(Egress)All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VM Traffic - ${var.tl_short_name}"
  }
}


