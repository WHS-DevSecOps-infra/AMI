# 📦 DevSecOps 표준 AMI 빌드 프로젝트

본 프로젝트는 Packer와 Ansible을 사용하여 보안 설정이 내재된 AWS AMI를 자동으로 빌드하고, GitHub Actions를 통해 CI 파이프라인을 구성하는 DevSecOps 인프라 구성 예제입니다.

---

## 프로젝트 구성

| 구성 요소 | 설명 |
|-----------|------|
| `packer-template.json` | AMI 빌드를 위한 Packer 템플릿 |
| `ansible/playbook.yml` | EC2 프로비저닝을 위한 Ansible 플레이북 |
| `ansible/roles/` | 역할 기반 하드닝 및 설치 스크립트 |
| `.github/workflows/ami-build.yml` | GitHub Actions 자동화 워크플로우 |

---


