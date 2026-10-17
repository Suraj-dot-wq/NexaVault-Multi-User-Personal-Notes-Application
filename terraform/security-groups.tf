# ==========================================
# Jenkins Controller Security Group
# ==========================================

resource "aws_security_group" "jenkins_controller_sg" {
  name        = "nexavault-jenkins-controller-sg"
  description = "Security group for Jenkins Controller"
  vpc_id      = aws_vpc.nexavault_vpc.id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins Web UI / GitHub Webhook
  ingress {
    description = "Jenkins Web UI and GitHub Webhook"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "NexaVault-Jenkins-Controller-SG"
  }
}


# ==========================================
# Jenkins Agent / NexaVault Security Group
# ==========================================

resource "aws_security_group" "jenkins_agent_sg" {
  name        = "nexavault-jenkins-agent-sg"
  description = "Security group for Jenkins Agent and NexaVault"
  vpc_id      = aws_vpc.nexavault_vpc.id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # NexaVault through Nginx
  ingress {
    description = "NexaVault HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins Agent communication
  ingress {
    description     = "Jenkins Agent Remoting"
    from_port       = 50000
    to_port         = 50000
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_controller_sg.id]
  }

  # Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "NexaVault-Jenkins-Agent-SG"
  }
}

