#terraform backend
terraform{
  backend "s3" {
    bucket  = "pfp-s3bucket"
    key     = "my_terraform_pfp"
    region  = "us-west-1"
  } 
}
# Configure the AWS Provider
provider "aws" {
   region  = var.region
}

# Create VPC
resource "aws_vpc" "pfp_vpc" {
  cidr_block = var.vpc_cidr

#   tags = {
#     Project = "pfp_demo"
#     Name = "pavan_pfp_vpc"
#  }
}

# Create Public Subnet1

resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.pfp_vpc.id
  cidr_block              = var.pub_sub1_cidr_block
  availability_zone       = "us-west-1b"
  map_public_ip_on_launch = true
#   tags = {
#     Project = "pfp_demo"
#      Name = "public_subnet1"
 
#  }
}

# Create Public Subnet2

resource "aws_subnet" "pub_sub2" {
  vpc_id                  = aws_vpc.pfp_vpc.id
  cidr_block              = var.pub_sub2_cidr_block
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true
#   tags = {
#     Project = "pfp_demo"
#     Name = "public_subnet2" 
#  }
}

# Create Private Subnet1

resource "aws_subnet" "prv_sub1" {
  vpc_id                  = aws_vpc.pfp_vpc.id
  cidr_block              = var.prv_sub1_cidr_block
  availability_zone       = "us-west-1b"
  map_public_ip_on_launch = false

#   tags = {
#     Project = "pfp_demo"
#     Name = "private_subnet1" 
#  }
}

# Create Private Subnet2

resource "aws_subnet" "prv_sub2" {
  vpc_id                  = aws_vpc.pfp_vpc.id
  cidr_block              = var.prv_sub2_cidr_block
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = false

  # tags = {
  #   Project = "pfp_demo"
  #   Name = "private_subnet2"
  # }
}

# Create Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.pfp_vpc.id

  tags = {
    Project = "pfp_demo"
    Name = "internet_gateway" 
 }
}

# Create Public Route Table for pub_sub1

resource "aws_route_table" "pub_sub1_rt" {
  vpc_id = aws_vpc.pfp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

#   tags = {
#     Project = "pfp_demo"
#     Name = "public_subnet_route_table" 
#  }
}

resource "aws_route" "pub_sub1_route" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id      = aws_internet_gateway.igw.id
}

# Create route table association of public subnet1

resource "aws_route_table_association" "internet_for_pub_sub1" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub1.id
}

# Create Public Route Table for pub_sub2

resource "aws_route_table" "pub_sub2_rt" {
  vpc_id = aws_vpc.pfp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

#   tags = {
#     Project = "pfp_demo"
#     Name = "public_subnet_route_table" 
#  }
}

resource "aws_route" "pub_sub2_route" {
  route_table_id = aws_route_table.pub_sub2_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id      = aws_internet_gateway.igw.id
}

# Create route table association of public subnet2

resource "aws_route_table_association" "internet_for_pub_sub2" {
  route_table_id = aws_route_table.pub_sub2_rt.id
  subnet_id      = aws_subnet.pub_sub2.id
}

# Create EIP for NAT GW1
  resource "aws_eip" "eip_natgw1" {
  count = "1"
}

# Create NAT gateway1

resource "aws_nat_gateway" "natgateway_1" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw1[count.index].id
  subnet_id     = aws_subnet.pub_sub1.id
}

# Create EIP for NAT GW2

resource "aws_eip" "eip_natgw2" {
  count = "1"
}

# Create NAT gateway2

resource "aws_nat_gateway" "natgateway_2" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw2[count.index].id
  subnet_id     = aws_subnet.pub_sub2.id
}

# Create private route table for prv sub1

resource "aws_route_table" "prv_sub1_rt" {
  count  = "1"
  vpc_id = aws_vpc.pfp_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_1[count.index].id
    # gateway_id    = aws_internet_gateway.igw.id
  }
#   tags = {
#     Project = "pfp_demo"
#     Name = "private_subnet1_route_table" 
#  }
}

# Create route table association betn prv sub1 & NAT GW1

resource "aws_route_table_association" "pri_sub1_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub1_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub1.id
}

# Create private route table for prv sub2

resource "aws_route_table" "prv_sub2_rt" {
  count  = "1"
  vpc_id = aws_vpc.pfp_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_2[count.index].id
    # gateway_id    = aws_internet_gateway.igw.id
  }
  # tags = {
  #   Project = "pfp_demo"
  #   Name = "private_subnet2_route_table"
  # }
}

# Create route table association betn prv sub2 & NAT GW2

resource "aws_route_table_association" "pri_sub2_to_natgw2" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub2_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub2.id
}

# Create security group for load balancer

resource "aws_security_group" "alb_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.pfp_vpc.id

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
#  tags = {
#     Name = var.sg_tagname
#     Project = "pfp_demo" 
#   } 
}

# Create security group for webserver

resource "aws_security_group" "webserver_sg" {
  name        = var.sg_ws_name
  description = var.sg_ws_description
  vpc_id      = aws_vpc.pfp_vpc.id

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]

 }

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

#  tags = {
#     Name = var.sg_ws_tagname 
#     Project = "pfp_demo"
#   }
}

#Resource to Create Key Pair

# resource "aws_key_pair" "asg_key_pair" {
#   key_name   = var.key_pair_name
#   public_key = var.public_key
# }

#Create a data source local_file

data "local_file" "ami_id"{
  depends_on = [null_resource.ami_id]     #wait for lc to be created by terraform
  filename = "../ami.txt"
}

resource "null_resource" "ami_id" {
  triggers = {
    ami_id = "{../ami.txt}"
  }
}

#Create Launch config

resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix   = "webserver-launch-config"
  image_id      =  data.local_file.ami_id.content
  instance_type = "t3.micro"
  # key_name = aws_key_pair.asg_key_pair.key_name
  security_groups = ["${aws_security_group.webserver_sg.id}"]
  # associate_public_ip_address = true
  root_block_device {
            volume_type = "gp2"
            volume_size = 10
            encrypted   = true
        }

  lifecycle {
    create_before_destroy = true
  }
}

#Create Auto Scaling policy
resource "aws_autoscaling_policy" "pfp-asp" {
  name                   = "pfp-asp"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.pfp-asg.name
}


# Create Auto Scaling Group
resource "aws_autoscaling_group" "pfp-asg" {
  name     = "pfp-asg"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  force_delete       = true
  depends_on     = [aws_lb.pfp-alb]
  target_group_arns  =  ["${aws_lb_target_group.pfp-tg.arn}"]
  health_check_type  = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier = ["${aws_subnet.prv_sub1.id}","${aws_subnet.prv_sub2.id}"]
  
#  tag {
#     key                 = "Name"
#     value               = "pfp-asg"
#     propagate_at_launch = true
#     }
}

# Create Target group

resource "aws_lb_target_group" "pfp-tg" {
  name     = "pfp-targetgroup-tg"
  depends_on = [aws_vpc.pfp_vpc]
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.pfp_vpc.id}"
#   health_check {
#     interval            = 70
#     path                = "/index.html"
#     port                = 80
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 60 
#     protocol            = "HTTP"
#     matcher             = "200,202"
#   }
}

# Create ALB

resource "aws_lb" "pfp-alb" {
   name              = "Demo-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.pub_sub1.id,aws_subnet.pub_sub2.id]

#   tags = {
# name  = "Demo-AppLoadBalancer-tf"
#     Project = "pfp_demo"
#   }
}

# Create ALB Listener 

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.pfp-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pfp-tg.arn
  }
}


