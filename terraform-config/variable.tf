variable "ami"{
 type = string
  default = "ami-0f8e81a3da6e2510a"
}

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

