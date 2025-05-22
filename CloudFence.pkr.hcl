packer {
  required_plugins {
    amazon = { # 아마존 리눅스
      version = ">= 0.0.1" # 현재 버전
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "cis-amazon-linux-2" {
  ami_name      = "WHS-CloudFence"
  region        = "ap-northeast-2" # AWS 리전
  instance_type = "t2.micro"    # 인스턴스 타입

  source_ami_filter {
    filters = {
        name = "amzn2-ami-hvm-*-x86_64-gp2"
        virtualization-type = "hvm"
        root-device-type = "ebs"
    }
    owners = ["137112412989"]
    most_recent = true
  }
    ssh_username = "ec2-user" # SSH 사용자 이름
}

  build {
    sources = [
      "source.amazon-ebs.cis-amazon-linux-2"
    ]

    provisioner "ansible" {
      playbook_file = "./ansible/playbook.yml"
    }
  }
