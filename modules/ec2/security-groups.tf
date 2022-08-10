### SECURITY GROUPS

resource "aws_security_group" "default" {
  name        = "Console Traffic - ${terraform.workspace} - ${var.tl_short_name}"
  description = "Console Traffic - ${terraform.workspace} - ${var.tl_short_name}"
  vpc_id      = var.vpc

  ingress {
    description = "(Ingress)8081-8083"
    from_port   = 8081
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
    Name = "Console Traffic - ${var.tl_short_name}"
  }
}


resource "aws_security_group" "default-LB" {
  name        = "ALB Traffic - ${terraform.workspace} -${var.tl_short_name}"
  description = "ALB Traffic - ${terraform.workspace} -${var.tl_short_name}"
  vpc_id      = var.vpc

  ingress {
    description = "(Ingress)443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description     = "(Egress)8081-8083"
    from_port       = 8081
    to_port         = 8083
    protocol        = "tcp"
    security_groups = [aws_security_group.default.id]
  }

  tags = {
    Name = "ALB Traffic - ${var.tl_short_name}"
  }
}


