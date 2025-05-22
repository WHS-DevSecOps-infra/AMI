# AMI

Nginx 웹 서버와 CIS Benchmark 기반 보안 하드닝이 적용된 AWS EC2 AMI를 생성하는 Packer 프로젝트입니다. 
이 프로젝트는 안전한 웹 서버 환경을 구축하기 위해 SSH 보안, 방화벽 설정, 시스템 감사 등을 자동화합니다.

## 프로젝트 개요
- **목표**: 보안이 강화된 Ubuntu AMI 생성.
- **기술**: Packer, Ansible
- **주요 기능**:
  - CIS / STIG 등 보안 사항에 중점을 둔 AMI 생성


## 설치
1. **의존성 설치**:
   ```bash
   pip install ansible
   packer init .
   ```

2. **디렉토리 구조**:
   ```
   .
   ├── CloudFence.pkr.hcl
   └── ansible/
       ├── playbook.yml
       └── cis-harden.yml
   ```

## 사용 방법
1. **AWS 자격 증명 설정**:
   ```bash
   export AWS_DEFAULT_REGION="ap-northeast-2"
   export AWS_ACCESS_KEY_ID="<your-key-id>"
   export AWS_SECRET_ACCESS_KEY="<your-secret-key>"
   ```

2. **구문 검증**:
   ```bash
   ansible-playbook --syntax-check ansible/playbook.yml
   ansible-playbook --syntax-check ansible/cis-harden.yml
   packer validate CloudFence.pkr.hcl
   ```

4. **플러그인 설치**:
    ```bash
    packer plugins install github.com/hashicorp/ansible
    ```

3. **AMI 빌드**:
   ```bash
   packer build CloudFence.pkr.hcl
   ```

    


## 주요 구성
- **CloudFence.pkr.hcl**: AMI를 빌드하며 Ansible 프로비저닝 호출.
- **playbook.yml**: Nginx 설치, UFW 방화벽 설정, CIS 하드닝 태스크 호출.
- **cis-harden.yml**: SSH 보안, 패스워드 정책, auditd, rsyslog, 네트워크 보안 설정.
