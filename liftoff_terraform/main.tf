
locals {
  # Autoscaling Group vars
  asg_ami      = "ami-016038ae9cc8d9f51"
  asg_ami_type = "t3.micro"
}

# Create an auto scaling group
resource "aws_launch_template" "launch_template0" {
  name_prefix            = "launch_template0"
  image_id               = local.asg_ami
  instance_type          = local.asg_ami_type
  key_name               = "instance_key"
  vpc_security_group_ids = [aws_security_group.sg_private.id]
}

resource "aws_autoscaling_group" "asg0" {
  name                = "asg0"
  vpc_zone_identifier = [aws_subnet.private.id]
  desired_capacity    = 3
  max_size            = 4
  min_size            = 1
  health_check_type   = "EC2"


  launch_template {
    id      = aws_launch_template.launch_template0.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_subnet.private]
}

resource "aws_autoscaling_group" "asg1" {
  name                = "asg1"
  vpc_zone_identifier = [aws_subnet.private.id]
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  health_check_type   = "EC2"


  launch_template {
    id      = aws_launch_template.launch_template0.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_subnet.private]
}

# Create an ec2 instance which acts as the jump host
resource "aws_instance" "jump_host" {
  ami                    = local.asg_ami
  instance_type          = local.asg_ami_type
  key_name               = "instance_key"
  vpc_security_group_ids = [aws_security_group.sg_public.id]
  subnet_id              = aws_subnet.public.id

  tags = {
    Name = "jump_host"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_security_group.sg_public]

}

resource "aws_network_interface_attachment" "jump_host_eni0" {
  instance_id          = aws_instance.jump_host.id
  network_interface_id = aws_network_interface.eni0.id
  device_index         = 1

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_instance.jump_host, aws_network_interface.eni0]
}
