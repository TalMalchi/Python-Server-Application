output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.jenkins-server.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.jenkins-server.public_ip
}

output "security_group_id" {
  description = "ID of the security group associated with the instance"
  value       = aws_security_group.jenkins-server.id
}

output "key_name" {
  description = "Name of the SSH key pair used to access the instance"
  value       = aws_key_pair.deployed_key.key_name
  
}
# Output Jenkins URL and initial password instructions
output "jenkins_url" {
  value = "http://${aws_instance.jenkins-server.public_ip}:8080"
}

output "jenkins_initial_password_command" {
  value = "To get the initial admin password, connect to the instance via SSH and run: cat /home/ubuntu/jenkins-initial-password"
}