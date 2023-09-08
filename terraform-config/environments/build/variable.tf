# variable "ami"{
#  type = string
#   default = "ami-0f8e81a3da6e2510a"
# }

# variable "key_pair_name" {
#   type    = string
#   default = "asg_key"
# }

# variable "public_key" {
#   type    = string
#   default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWjVRzMIyHeSih2A9IXhraMpIaaK5sH80K/7PimRQjI2V/MPYtkcrqoNAgun/gcZKYI5QMMT28rUbhU0lE3UYejq0YdXvrlv3paSLriYra50rd5CMo3vsR2Pt0Hh8VYZznbZMIWvXK03CxRBemFwfeUxTmzJfYbFQre8Q2r8V86V7C0jALRiRZshba7+aZNscQEwj/+q9GaNd82tExLuUzzbjx7Obi6+CHQDz6/w9jKwuL0kLB+z/SwhC1e0ZJe4oSWTQBAd85jCgjb16vTwj7Pj30rIwbRhFb42n0MAWQoXjfag4hdR7E4srAtzZtml1JnT8gdT5xou/BrryntLQXelV6NRablclcbHEJRS1IUeoPNYmK9P5EgxV7PPZDp1NMs5DXAhCRhKZD6Xq89K/lSxUg2SDCQhDLpS7d29aGDRxGSTwQvdarbClrAXH9IlnMyACB3XT5zXk03NzIbw7yx4A2m2gN8TDKAQhABNQQXCSIOoMtu0JoUboghYbSaQAPTsk2vr3kX2SWDjxuvFPQEYTxfuknBs/BD9IpfaeWswf25vtL52DrJltbnpfWUap+FZqqig9MAnD+00nYxKuTm0yEAzdFvJu0HDbsaMy+CvMnQ14zOXS6AfInKFwV5clGBCcMW1G4rbg9bH8OIcu/dV3ZQgoYbQwGqtVPda2DIQ== ubuntu@ip-172-31-30-12"
# }

variable "region" {
  type        = string
  default     = "us-west-1"
  description = "default region"
}

variable "vpc_cidr" {
  type        = string
  default     = "172.16.0.0/24"
  description = "default vpc_cidr_block"
}

variable "pub_sub1_cidr_block"{
   type        = string
   default     = "172.16.1.0/26"
}

variable "pub_sub2_cidr_block"{
   type        = string
   default     = "172.16.2.0/26"
}
variable "prv_sub1_cidr_block"{
   type        = string
   default     = "172.16.3.0/26"
}
variable "prv_sub2_cidr_block"{
   type        = string
   default     = "172.16.4.0/26"
}


variable "sg_name"{
 type = string
 default = "alb_sg"
}

variable "sg_description"{
 type = string
 default = "SG for application load balancer"
}

variable "sg_tagname"{
 type = string
 default = "SG for ALB"
}

variable "sg_ws_name"{
 type = string
 default = "webserver_sg"
}

variable "sg_ws_description"{
 type = string
 default = "SG for web server"
}

variable "sg_ws_tagname"{
 type = string
 default = "SG for web"
}

# variable "associate_public_ip_address" {
#    type = bool
#    default = true
# }



