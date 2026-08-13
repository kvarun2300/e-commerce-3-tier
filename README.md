# Cloud-Native E-Commerce 3-Tier Application

A resume-ready 3-tier e-commerce application for AWS EKS.

## Architecture

Internet -> AWS ALB / Ingress -> React/Nginx Frontend -> Spring Boot Backend -> MySQL RDS

For local development, MySQL can run with Docker Compose.

## Stack

- Frontend: React + Vite + Nginx
- Backend: Java 17 + Spring Boot + JPA
- Database: MySQL 8
- Containers: Docker
- Kubernetes: EKS
- Ingress: AWS Load Balancer Controller
- CI/CD: Jenkins
- Registry: Amazon ECR
- Security: Trivy
- Code quality: SonarQube
- Infrastructure: Terraform

## Local run

1. Start MySQL:
   docker compose up -d mysql

2. Start backend:
   cd backend
   mvn spring-boot:run

3. Start frontend:
   cd frontend
   npm install
   npm run dev

The frontend uses `VITE_API_URL=http://localhost:8080/api`.

## Docker local run

docker compose up --build

Frontend: http://localhost:3000
Backend: http://localhost:8080/api/products

## EKS deployment

1. Build and push frontend/backend images to ECR.
2. Edit `k8s/secret.yaml` with your RDS credentials.
3. Edit image names in the deployment files.
4. Install AWS Load Balancer Controller in the EKS cluster.
5. Apply:

   kubectl apply -f k8s/namespace.yaml
   kubectl apply -f k8s/configmap.yaml
   kubectl apply -f k8s/secret.yaml
   kubectl apply -f k8s/backend-deployment.yaml
   kubectl apply -f k8s/backend-service.yaml
   kubectl apply -f k8s/frontend-deployment.yaml
   kubectl apply -f k8s/frontend-service.yaml
   kubectl apply -f k8s/ingress.yaml

For production, replace the sample Kubernetes Secret with AWS Secrets Manager / External Secrets.

## Terraform

The Terraform folder provides a basic VPC + EKS + managed node group + RDS foundation. Review CIDRs, instance sizes, credentials, and costs before applying.
