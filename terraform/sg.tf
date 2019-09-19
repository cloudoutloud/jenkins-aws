# Security group configuration
resource "aws_security_group" "jenkins-sg" {
  name          = "jenkins-sg"
  description   = "Allow default administration for jenkins"
  vpc_id        = "${aws_vpc.jenkins-network.id}"
  tags          = {
    Name        = "jenkins-sg"
  }

  # Inbound ssh access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound jenkins port access
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}