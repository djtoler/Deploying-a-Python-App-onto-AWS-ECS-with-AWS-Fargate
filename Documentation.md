## Purpose

The purpose of this project is to streamline the deployment process for a web application, consisting of a Dockerized frontend and a Dockerized backend, on Amazon Web Services (AWS) using ECS (Elastic Container Service). Additionally, the documentation includes the creation of a Jenkins manager and agent architecture for continuous integration and deployment. The project aims to enhance security by implementing a Python script that automatically checks for sensitive information, such as AWS secret keys and access keys, before allowing code pushes to GitHub.

## Python Script

## Terraform and .tf files
Terraform is an open-source infrastructure as code (IaC) tool that allows you to define and provision infrastructure resources using declarative configuration files. It automates the deployment and management of cloud resources, making it easier to maintain and scale infrastructure in a consistent and repeatable manner.
Terraform was used to create a Jenkins manager and agents architecture within a default VPC.

**Instance 1:**
Jenkins installation with Docker pipeline plugin.

**Instance 2 (T.2 medium):**
Docker and default-jre installation.

**Instance 3:**
Terraform and default-jre installation.

# ECS and VPC Terraform Files:

Terraform files are included to define the AWS infrastructure. This includes setting up two Availability Zones (AZs), two public subnets, frontend and backend containers, a route table, security group configurations, and an Application Load Balancer (ALB).

## Docker and Dockerfiles

A Docker image is a lightweight, standalone, and executable package that contains everything needed to run a piece of software, including the code, runtime, system tools, and libraries. Docker images are created from a set of instructions defined in a Dockerfile. They serve as the blueprint for containers.
For this deployment, Docker images are provided for both the backend and frontend components. Instructions for building these images are outlined in two docker files, ensuring consistency and reproducibility across deployment environments.

**Backend**
<img width="768" alt="Screen Shot 2023-11-11 at 7 50 40 PM" src="https://github.com/SaraGurungLABS01/Deployment8/assets/140760966/0306cfc4-c27b-45b4-ab36-bef373a9fc44">

**Frontend**
<img width="693" alt="Screen Shot 2023-11-11 at 7 52 35 PM" src="https://github.com/SaraGurungLABS01/Deployment8/assets/140760966/a54c0558-0e5d-43e4-8f9e-6e29031d0f5c">
