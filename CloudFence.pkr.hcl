packer {
  required_plugins {
    amazon = { # 아마존 리눅스
      version = ">= 1.3.6" # 현재 버전
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "Ubuntu" {
  ami_name      = "WHS-CloudFence-{{timestamp}}" # AMI 이름 충돌 방지
  region        = "ap-northeast-2" # AWS 리전
  instance_type = "t2.micro"    # 인스턴스 타입

  ssh_timeout = "10m" 

  source_ami_filter {
    filters = {
        name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
        virtualization-type = "hvm"
        root-device-type = "ebs"
    }
    owners = ["099720109477"]
    most_recent = true
  }
    ssh_username = "ubuntu" # SSH 사용자 이름

    tags = {
  Name        = "WHS-CloudFence"
  Environment = "Production"
  CreatedBy   = "Packer"
}
}



  build {
    sources = [
      "source.amazon-ebs.Ubuntu"
    ]

    provisioner "ansible" {
      playbook_file = "./ansible/playbook.yml"
    }
  }
