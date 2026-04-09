provider "aws" {
  region = "us-east-1" 
}

resource "aws_instance" "foodexpress_server" {
  # AMI for Amazon Linux 2023 in us-east-1 (as of early 2026)
  ami           = "ami-051f8b2110b52e9f0" 
  instance_type = "t2.micro"
  key_name      = "foodexpress-key" 

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # This script runs on startup to prepare the environment
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y docker
              systemctl start docker
              systemctl enable docker
              # Give ec2-user permissions to run docker without sudo
              usermod -aG docker ec2-user
              EOF

  tags = { 
    Name = "FoodExpress-Prod-USEast"
    Project = "FoodExpress"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "foodexpress-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In a real job, use your specific IP here!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.foodexpress_server.public_ip
}
