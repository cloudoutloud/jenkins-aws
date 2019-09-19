#Create jenkins instance
resource "aws_instance" "jenkins-master" {
  ami                    = "${var.aws_ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]
  subnet_id              = "${aws_subnet.subnet.id}"
  iam_instance_profile   = "${aws_iam_instance_profile.jenkins_profile.name}"
  associate_public_ip_address = "true"
  ebs_block_device {
    device_name = "/dev/sda1"
    delete_on_termination = true
    size = 8
  }

  tags = {
    Name = "jenkins-master"
    ManagedBy = "Terraform"
    IamInstanceRole = "${aws_iam_role.jenkins_iam_role.name}"
  }

#Check ssh connection with instance 
provisioner "remote-exec" {
  inline = ["echo Ready"]

  connection {
    host = "${aws_instance.jenkins-master.public_ip}"
    type = "ssh"
    user = "centos"
    private_key = "${file("~/.ssh/london.pem")}"
  }
}

#Transfers script to jenkins instance
provisioner "file" {
    source      = "./scripts/"
    destination = "/tmp/"

    connection {
    host = "${aws_instance.jenkins-master.public_ip}"
    type = "ssh"
    user = "centos"
    private_key = "${file("~/.ssh/london.pem")}"
  }
} 

#Execute script on jenknins host
provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/*sh",
     "bash /tmp/jenkins-setup.sh"
     ]

  connection {
    host = "${aws_instance.jenkins-master.public_ip}"
    type = "ssh"
    user = "centos"
    private_key = "${file("~/.ssh/london.pem")}"
  }
}

#Ansbile code
#  provisioner "local-exec" {
#       command = "sleep 30; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u centos --private-key ~/.ssh/london.pem -i '${aws_instance.jenkins-master.public_ip},' ansible/jenkins-setup.yaml"
#     }

}      
 