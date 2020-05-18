resource "aws_instance" "app1" {
  instance_type = "t2.micro"
  ami           = "ami-03b5297d565ef30a6"
  key_name      = "aws"
  user_data = "${file("app-deploy.sh")}"
  
  tags = {
    "type" = "terraform-test-instance"
	"Name" = "APP-Servers"
  }
}

resource "aws_security_group" "sg" {
  name= "Allow_Tomcat"
  description= "Allow Tomcat port inbound"
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "SSH from Ansible"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    "type" = "terraform-test-security-group"
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.sg.id
  network_interface_id = aws_instance.app1.primary_network_interface_id
}