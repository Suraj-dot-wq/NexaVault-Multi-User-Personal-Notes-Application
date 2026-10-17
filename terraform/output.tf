output "nexavault_controller_public_ip" {
  description = "Public IP of the new NexaVault Jenkins Controller"
  value       = aws_instance.nexavault_controller.public_ip
}

output "nexavault_controller_private_ip" {
  description = "Private IP of the new NexaVault Jenkins Controller"
  value       = aws_instance.nexavault_controller.private_ip
}

output "nexavault_agent_public_ip" {
  description = "Public IP of the new NexaVault Jenkins Agent"
  value       = aws_instance.nexavault_agent.public_ip
}

output "nexavault_agent_private_ip" {
  description = "Private IP of the new NexaVault Jenkins Agent"
  value       = aws_instance.nexavault_agent.private_ip
}

output "nexavault_vpc_id" {
  description = "NexaVault Custom VPC ID"
  value       = aws_vpc.nexavault_vpc.id
}

output "nexavault_public_subnet_id" {
  description = "NexaVault public subnet ID"
  value       = aws_subnet.public.id
}

