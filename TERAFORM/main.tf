resource "aws_instance" "EC2" {
  availability_zone = var.availability_zone
  ami = var.ami-ec2
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = data.template_cloudinit_config.config.rendered  
  tags = local.Instance-Name-Tag
  
}


data "template_file" "client" {
  template = file("projectfile/HIDS/SiteContent/django.sh")
}
data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.client.rendered
  }
}



resource "aws_ebs_volume" "EC2-EBS" {
  availability_zone = var.availability_zone
  size              = var.EBS_size

  tags = local.EBS-Tag
 
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.EC2-EBS.id
  instance_id = aws_instance.EC2.id
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key_name
}

resource "aws_security_group" "allow_tls" {
  name        = var.sg_name
  description = var.sg_description
  #vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 
  tags = local.SG-Tag
  
}

