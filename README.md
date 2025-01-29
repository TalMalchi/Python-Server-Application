# Arithmetic Python Server Application

## Overview

This project implements a client-server arithmetic calculator application. The system consists of a Python-based web application deployed using Docker, with infrastructure managed through Terraform and configuration handled by Ansible.

## Project Structure

### Infrastructure

- Terraform provisions an EC2 instance for Jenkins and configuring it to start at boot.
- Ansible installs and configures all the necessary dependencies (docker and aws-cli).

### Application

- A web-based application with a server and client.
- The client collects two numbers and an arithmetic operation, then sends the request to the server.
- The server processes the request, performs the operation, and sends back the result.
- The application logs every operation performed.
- The arithmetic operations are implemented using an abstract class with concrete methods.

### CI with Jenkins

- Each side (client/server) has a dedicated Jenkinsfile, triggered on new commit at the main repo (with webhook), and build new image just if there is a change in their respective directories.
- Jenkins pipelines use a [shared library](https://github.com/TalMalchi/jenkins-shared-libraries.git) for reusable functions 
- The pipelines build and push Docker images to Amazon Public ECR.
- Upon a new image build, the Docker Compose file is updated with the new image tag.

### Deployment Process

- Pull the repository is from GitHub when new images are built.
- The application is launched using docker-compose up.
- The application is accessible via localhost:5001.

## Setup and Deployment

### Prerequisites
- AWS Account
- Terraform & Ansible installed
- Docker & Docker Compose installed

### Steps

#### Infrastructure Deployment

Navigate to the Terraform directory:
```
cd terraform
terraform init
terraform validate
terraform apply -auto-approve
```
Use Ansible to install the dependencies :
```
ansible-playbook -i inventory/hosts.ini 
```
Configrue jenkins using initial password locate at
```
cat /home/ubuntu/jenkins-initial-password
```

#### CI Pipeline Execution
Create 2 pipelines on jenkins: one for client proccess, the other for server proccess
On a new commit on the repo , the respective Jenkins pipeline triggers according to change at client/ or server/ directory:
- Builds a new Docker image
- Pushes the image to ECR
- Updates the Docker Compose file

#### Application Setup

Clone this repository on your local machine and run the Docker containers:
```
git clone https://github.com/TalMalchi/jenkins-shared-libraries.git
cd web-app
docker-compose up 
```
#### Access the Application
- Open a web browser and navigate to:
- http://localhost:5001



