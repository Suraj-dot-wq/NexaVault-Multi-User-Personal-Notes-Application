# ==========================================
# NexaVault - New Custom VPC EC2 Instances
# ==========================================

resource "aws_instance" "nexavault_controller" {
  ami                         = "ami-01a00762f46d584a1"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.jenkins_controller_sg.id]
  key_name                    = "jenkins-key"
  associate_public_ip_address = true

  ebs_optimized = true
  monitoring    = false

  credit_specification {
    cpu_credits = "unlimited"
  }

  root_block_device {
    volume_size           = 15
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
  }

  tags = {
    Name        = "NexaVault-Jenkins-Controller-v2"
    Project     = "NexaVault"
    Environment = "Portfolio"
    Role        = "Jenkins-Controller"
    ManagedBy   = "Terraform"
  }
}


resource "aws_instance" "nexavault_agent" {
  ami                         = "ami-01a00762f46d584a1"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.jenkins_agent_sg.id]
  key_name                    = "jenkins-key"
  associate_public_ip_address = true

  ebs_optimized = true
  monitoring    = false

  credit_specification {
    cpu_credits = "unlimited"
  }

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
  }

  tags = {
    Name        = "NexaVault-App-Jenkins-Agent-v2"
    Project     = "NexaVault"
    Environment = "Portfolio"
    Role        = "Application-Jenkins-Agent"
    ManagedBy   = "Terraform"
  }
}