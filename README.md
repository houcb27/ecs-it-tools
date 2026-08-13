# ECS IT Tools Deployment

## Project Overview

This project demonstrates a production-grade cloud deployment of [IT Tools](https://github.com/CorentinTh/it-tools) — a collection of handy online tools for developers — containerised with Docker and deployed on AWS ECS Fargate. The infrastructure is fully automated using Terraform with modular design, and deployments are handled via GitHub Actions CI/CD pipelines with OIDC authentication.

Live URL: [https://tm.houcinebenzellat.uk](https://tm.houcinebenzellat.uk)

---

## Architecture

The application follows a production-grade AWS architecture:

- Users access the app via HTTPS through a custom domain
- Route 53 resolves the domain to an Application Load Balancer
- The ALB terminates SSL using an ACM certificate and forwards traffic to ECS
- ECS Fargate runs the containerised IT Tools application in private subnets
- A NAT Gateway allows ECS tasks to pull images from ECR

> Architecture diagram coming soon

---

## Tech Stack

| Technology | Purpose |
|-----------|---------|
| Docker | Containerisation with multi-stage build |
| AWS ECS Fargate | Container orchestration (serverless) |
| AWS ECR | Private Docker image registry |
| AWS ALB | Load balancing and HTTPS termination |
| AWS ACM | SSL/TLS certificate management |
| AWS VPC | Network isolation with public/private subnets |
| AWS Route 53 | DNS management |
| AWS IAM | OIDC authentication and least-privilege roles |
| Terraform | Infrastructure as Code with modular design |
| GitHub Actions | CI/CD pipelines with OIDC |

---

## Infrastructure

All infrastructure is defined as code using Terraform, split into 6 modules:

infra/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
└── modules/
├── vpc/ # VPC, subnets, IGW, NAT Gateway, route tables
├── ecr/ # Elastic Container Registry
├── iam/ # Task execution role and policies
├── acm/ # SSL certificate with DNS validation
├── alb/ # Application Load Balancer, listeners, target group
└── ecs/ # ECS cluster, task definition, service, security groups


**Terraform State** is stored remotely in S3 with versioning enabled for disaster recovery.

---

## CI/CD Pipelines

Three GitHub Actions pipelines automate the full deployment lifecycle:

| Pipeline | Trigger | Description |
|---------|---------|-------------|
| App Pipeline | Push to main | Builds Docker image and pushes to ECR tagged with commit SHA |
| Terraform Apply | Push to infra/** | Runs terraform init, fmt, validate, plan and apply |
| Terraform Destroy | Manual (workflow_dispatch) | Safely tears down all infrastructure |

All pipelines use **OIDC authentication** — no static AWS keys are stored anywhere.

---

## Project Structure

ecs-it-tools/
├── app/ # IT Tools source code
├── Dockerfile # Multi-stage Docker build
├── .dockerignore
├── nginx.conf # Custom nginx configuration
├── infra/ # Terraform modules
│ ├── modules/
│ │ ├── vpc/
│ │ ├── ecr/
│ │ ├── iam/
│ │ ├── acm/
│ │ ├── alb/
│ │ └── ecs/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── provider.tf
├── .github/
│ └── workflows/
│ ├── app.yml
│ ├── tf-apply.yml
│ └── tf-destroy.yml
└── README.md

---

## Local Setup

### Prerequisites

- Docker
- AWS CLI configured
- Terraform >= 1.0

### Run locally

```bash
# Clone the repo
git clone https://github.com/houcb27/ecs-it-tools
cd ecs-it-tools

# Build and run
docker build -t it-tools .
docker run -p 80:80 it-tools

# Visit http://localhost:80
```

### Deploy infrastructure

```bash
cd infra
terraform init
terraform plan
terraform apply
```

---

## Screenshots

### App Running Live

![IT Tools Live](screenshots/app-live.png)

### ECS Service Running

![ECS Service](screenshots/ecs-service.png)

### Terraform Apply

![Terraform Apply](screenshots/terraform-apply.png)

### CI/CD Pipeline

![Pipeline](screenshots/pipeline.png)

---

## Key Decisions

**Why ECS Fargate?** No server management — AWS handles provisioning, patching and scaling. I focus on the application and infrastructure code.

**Why private subnets for ECS?** Security best practice — containers are not directly exposed to the internet. All traffic flows through the ALB.

**Why OIDC instead of access keys?** OIDC tokens are temporary and expire after each job. No long-lived credentials stored in GitHub secrets.

**Why Terraform modules?** Separation of concerns — each module manages one layer of the infrastructure. Makes it easier to reason about, test, and reuse.

---

