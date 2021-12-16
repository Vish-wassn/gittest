variable "aws_region" {
       description = "The AWS region to create things in."
       default     = "ap-south-1"
}

variable "key_name" {
    description = " SSH keys to connect to ec2 instance"
    default     =  "rajath"
}

variable "instance_type" {
    description = "instance type for ec2"
    default     =  "t2.micro"
}

variable "my_vpc_secure" {
 description = "security group"
  default = "my_vpcsecure"
}

variable "tag_name" {
    description = "Tag Name of for Ec2 instance"
    default     = "my-ec2-instance"
}
variable "ami_id" {
    description = "AMI for Ubuntu Ec2 instance"
    default     = "ami-052cef05d01020f1d"
}

variable "my_vpc1" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "p_subnet12" {
  description = "CIDR for the public subnet"
  default = "10.0.1.0/24"
}
