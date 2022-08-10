resource "aws_instance" "default1" {
  ami                    = var.ami
  instance_type          = var.instance-type
  vpc_security_group_ids = [aws_security_group.default.id]
  key_name               = "sgordon-aws-pan-lab"
  tags = {
    Name = "SaaS Container - ${var.tl_short_name}"
  }
  user_data = data.template_file.container.rendered
  root_block_device {
    volume_size = "30"
    encrypted   = true
  }
  monitoring    = true
  ebs_optimized = true
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

}

resource "aws_instance" "default2" {
  ami                    = var.ami
  instance_type          = var.instance-type
  vpc_security_group_ids = [aws_security_group.default.id]
  key_name               = "sgordon-aws-pan-lab"
  tags = {
    Name = "SaaS Host - ${var.tl_short_name}"
  }
  user_data = data.template_file.host.rendered
  root_block_device {
    volume_size = "30"
    encrypted   = true
  }
  monitoring    = true
  ebs_optimized = true
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

}

data "template_file" "container" {
  template = file("${path.module}/templates/user-data-container.sh.tpl")

  vars = {
    tl_username = var.tl_username
    tl_password = var.tl_password
    tl_console = var.tl_console
  }

}

data "template_file" "host" {
  template = file("${path.module}/templates/user-data-host.sh.tpl")

  vars = {
    tl_username = var.tl_username
    tl_password = var.tl_password
    tl_console = var.tl_console
  }

}

resource "aws_route53_record" "default1" {
  name    = "${var.tl_short_name}.saas.container.prismacompute.site"
  zone_id = var.dns_zone
  ttl     = "60"
  type    = "A"
  records = [aws_instance.default1.public_ip]
}


resource "aws_route53_record" "default2" {
  name    = "${var.tl_short_name}.saas.host.prismacompute.site"
  zone_id = var.dns_zone
  ttl     = "60"
  type    = "A"
  records = [aws_instance.default2.public_ip]
}