
locals {
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deployed_key" {
  key_name   = "jenkins-server"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  filename = "${path.cwd}/jenkins-server.pem"
  content  = tls_private_key.ssh_key.private_key_pem
  file_permission = "0400"  # Secure the private key file
}


resource "aws_security_group" "jenkins-server" {
  name        = "${var.project_name}-jenkins-server-sg"
  description = "Security group for Jenkins server"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to your IP or admin IP range
  }

  ingress {
    description      = "For Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${var.project_name}-ci-cd-server-sg" })
}

resource "aws_instance" "jenkins-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.deployed_key.key_name
  tags = merge(local.tags, { Name = "${var.project_name}-ci-cd-server" })
  security_groups = [aws_security_group.jenkins-server.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install openjdk-21-jdk -y 
              sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update -y
              sudo apt-get install jenkins -y
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              sudo cat /var/lib/jenkins/secrets/initialAdminPassword > /home/ubuntu/jenkins-initial-password
              sudo chown ubuntu:ubuntu /home/ubuntu/jenkins-initial-password
  EOF
}

