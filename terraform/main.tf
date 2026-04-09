provider "aws" {
  region = "us-east-1"
}

# Security Group
resource "aws_security_group" "web" {
  name        = "foodexpress-sg"
  description = "Allow HTTP"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "app" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu 20.04 in us-east-1
  instance_type = "t2.micro"
  
  # IMPORTANT: Change "your-key-name" to your actual AWS Key Pair name
  key_name      = "foodexpress-key" 

  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              sleep 20 # CRITICAL: Wait for Docker to finish starting
              sudo docker run -d -p 80:3000 143mom/foodexpress-app:latest
              EOF

  tags = {
    Name = "FoodExpress-App"
  }
}

# Output the IP so you can find your website easily
output "website_url" {
  value = "http://${aws_instance.app.public_ip}"
}
