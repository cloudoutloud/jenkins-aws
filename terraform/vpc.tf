# VPC creation
resource "aws_vpc" "jenkins-network" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags = {
    Name = "jenkins-network"
    ManagedBy = "Terraform"
  }
}

# Create a route to internet
resource "aws_route" "route" {
  route_table_id = "${aws_vpc.jenkins-network.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.gw.id}"
}

# Subnet configuration
resource "aws_subnet" "subnet" {
  vpc_id       = "${aws_vpc.jenkins-network.id}"
  cidr_block   = "${var.subnet["cidr"]}"
  tags         = {
    Name       = "public_subnet"
  }
  depends_on   = ["aws_internet_gateway.gw"]
}

# External gateway configuration
resource "aws_internet_gateway" "gw" {
  vpc_id       = "${aws_vpc.jenkins-network.id}"
  tags         = {
    Name       = "internet-gateway"
    ManagedBy  = "Terraform"
  }
}