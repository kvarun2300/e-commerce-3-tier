# Architecture

## Runtime

ALB
-> frontend-service
-> React/Nginx pods

The Nginx frontend proxies `/api/*` to `backend-service`.

backend-service
-> Spring Boot pods
-> RDS MySQL

## Why RDS instead of MySQL in EKS?

The application tier belongs in Kubernetes while the managed database tier is handled by Amazon RDS. This reduces operational overhead and demonstrates a more realistic cloud architecture.

## Security

- RDS is private.
- MySQL is not exposed to the internet.
- Kubernetes Secret holds database credentials for the sample project.
- Replace the sample Secret with AWS Secrets Manager/External Secrets for a stronger production implementation.
