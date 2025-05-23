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

1. **구문 검증**:
   ```bash
   ansible-playbook --syntax-check ansible/playbook.yml
   ansible-playbook --syntax-check ansible/cis-harden.yml
   packer validate CloudFence.pkr.hcl
   ```

2. **플러그인 설치**:
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


## 진행 예정
- CIS Benchmark로 진행 (필요한 부분을 나눠서 적용하기)
- 변수를 var로 분리하여 사용 편의성 향상
- github Actions을 이용해서 자동화
- 오류나 부족한 부분 수정해서 AMI 확인하기
- packer로 만들 이미지 자체에 보안 설정이 되도록 하는 방법 고려하기