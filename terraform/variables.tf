#ssh key
variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "london"
}

#region
variable "aws_region" {
  description = "aws region to launch custer."
  default = "eu-west-2"
}

#availability zones
variable "aws_zones" {
  // London eu-west-2
      default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
} 

#ami-centos-7-1.11.3-00-1537830214
variable "aws_ami" {
  description = "ami used for cluster"
  default = "ami-03a0ef6f0d2067f46"
}

#vpc cidr
variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

#vpc subnet
variable "subnet" {
  default = {
    subnet_name  = "subnet"
    cidr         = "192.168.1.0/24"
  }
}

#instance type
variable "instance_type" {
  description = "AWS instance type for Jenkins"
  default = "t2.medium"
}

