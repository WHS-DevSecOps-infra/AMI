packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "vpc_id" {}
variable "subnet_id" {}
variable "security_group_id" {}

source "amazon-ebs" "devsecops" {
  region                     = "ap-northeast-2"
  source_ami                 = "ami-05377cf8cfef186c2" # Amazon Linux 2023
  instance_type              = "t2.micro"
  ssh_username               = "ec2-user"
  ssh_interface              = "public_ip"
  associate_public_ip_address = true
  pause_before_connecting    = "10s"
  temporary_key_pair_type    = "ed25519"

  vpc_id           = var.vpc_id
  subnet_id        = var.subnet_id
  security_group_id = var.security_group_id

  ami_name         = "devsecops-ami-{{timestamp}}"
  ami_description  = "Base DevSecOps AMI with Ansible Provisioning"

  tags = {
    Name           = "devsecops-ami"
    BaseAMI_Id     = "ami-05377cf8cfef186c2"
    TEAM           = "DevSecOps Team"
    Environment    = "Development"
    BuildDate      = "{{timestamp}}"
  }
}

build {
  sources = ["source.amazon-ebs.devsecops"]

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
    extra_arguments = [
      "--ssh-extra-args=-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa"
    ]
  }
}
