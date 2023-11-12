## Purpose

The purpose of this project is to streamline the deployment process for a web application, consisting of a Dockerized frontend and a Dockerized backend, on Amazon Web Services (AWS) using ECS (Elastic Container Service). Additionally, the documentation includes the creation of a Jenkins manager and agent architecture for continuous integration and deployment. The project aims to enhance security by implementing a Python script that automatically checks for sensitive information, such as AWS secret keys and access keys, before allowing code pushes to GitHub.

## Python Script

The Python script, `check_sensitive.py`, serves as a crucial security measure in our development workflow. Its primary function is to meticulously examine all files within the project directory and its subdirectories, employing pattern matching to identify potential instances of sensitive information, notably AWS secret keys and access keys. If any such information is detected, the script promptly notifies the user by printing a detailed message specifying the file and the type of sensitive data found. Importantly, the script acts proactively by preventing code pushes to GitHub in the presence of detected sensitive information. This functionality ensures that confidential data is not inadvertently exposed during the development process, contributing to a more secure and controlled deployment pipeline. It is recommended to run this script routinely, especially before attempting to push code changes to GitHub, either manually or as part of an automated pre-commit hook or CI/CD pipeline, thereby fortifying our commitment to maintaining the highest standards of security in our project.

## Terraform and .tf files
Terraform is an open-source infrastructure as code (IaC) tool that allows you to define and provision infrastructure resources using declarative configuration files. It automates the deployment and management of cloud resources, making it easier to maintain and scale infrastructure in a consistent and repeatable manner.
Terraform was used to create a Jenkins manager and agents architecture within a default VPC.

**Instance 1:**
Jenkins installation with Docker pipeline plugin.

**Instance 2 (T.2 medium):**
Docker and default-jre installation.

**Instance 3:**
Terraform and default-jre installation.

## ECS and VPC Terraform Files:

Terraform files are included to define the AWS infrastructure. This includes setting up two Availability Zones (AZs), two public subnets, frontend and backend containers, a route table, security group configurations, and an Application Load Balancer (ALB).

## Docker and Dockerfiles

A Docker image is a lightweight, standalone, and executable package that contains everything needed to run a piece of software, including the code, runtime, system tools, and libraries. Docker images are created from a set of instructions defined in a Dockerfile. They serve as the blueprint for containers.
For this deployment, Docker images are provided for both the backend and frontend components. Instructions for building these images are outlined in two docker files, ensuring consistency and reproducibility across deployment environments.

**Backend**
<img width="768" alt="Screen Shot 2023-11-11 at 7 50 40 PM" src="https://github.com/SaraGurungLABS01/Deployment8/assets/140760966/0306cfc4-c27b-45b4-ab36-bef373a9fc44">

**Frontend**
<img width="693" alt="Screen Shot 2023-11-11 at 7 52 35 PM" src="https://github.com/SaraGurungLABS01/Deployment8/assets/140760966/a54c0558-0e5d-43e4-8f9e-6e29031d0f5c">

## Jenkins and the Agents

## Jenkins Manager and Agent

Jenkins is an open-source automation server used for continuous integration (CI) and continuous delivery (CD) of software applications. It provides a framework to automate the building, testing, and deployment of software, enabling teams to integrate and deliver code more rapidly and efficiently.

Jenkins agents streamline CI/CD with parallel execution, resource isolation, and cross-platform support. They scale effortlessly, adapt to diverse project needs, and speed up testing. This efficiency reduces infrastructure costs and enhances reliability. Agents also support collaborative work and bolster security by controlling access and permissions.

### Jenkin Agent Nodes 

**awsdeploy2 - Docker Node**
Handles activities like testing the application, building the Docker image, and uploading it to Docker Hub.

**awsdeploy - Terraform Node**
Creates the entire application infrastructure.

[Step-by-Step Guide - Creating an Agent in Jenkins](https://scribehow.com/shared/Step-by-step_Guide_Creating_an_Agent_in_Jenkins__xeyUT01pSAiWXC3qN42q5w)

### Jenkin Credentials

To ensure Terraform's access to AWS, it necessitates both AWS access and secret keys. Given that the terraform files reside on GitHub, where public access should be restricted for security reasons, AWS credentials are created within Jenkins. Configuring AWS credentials within Jenkins is crucial as it fosters the integration of AWS services into your automation workflows, ensuring secure access to resources. Likewise, Docker Hub credentials, encompassing a username and password, are also established. These credentials are essential for secure interactions with Docker Hub, enabling your applications to be efficiently built, tested, and pushed to the container registry. 

**AWS**

To securely configure AWS credentials in Jenkins for the automation purpose, please refer to the following link for step-by-step instructions: [How to Configure AWS credentials in  Jenkins](https://scribehow.com/shared/How_to_Securely_Configure_AWS_Access_Keys_in_Jenkins__MNeQvA0RSOWj4Ig3pdzIPw)https://scribehow.com/shared/How_to_Securely_Configure_AWS_Access_Keys_in_Jenkins__MNeQvA0RSOWj4Ig3pdzIPw

**Docker Hub**

Follow the steps above, just make sure to select username and password for kind and add your dockerhub credentials

## Jenkin Files for ECS Terraform Deployment

These Jenkinsfiles are pivotal in maintaining a robust and automated deployment workflow for the ECS-based infrastructure, adhering to best practices for continuous integration and continuous deployment (CI/CD). 

**1. Jenkinsfile for Backend Deployment**

The Jenkinsfile for deploying the backend ECS Terraform files orchestrates the deployment process in a seamless manner.

**2. Jenkinsfile for Frontend Deployment**

The Jenkinsfile for deploying the frontend ECS Terraform files complements the backend deployment. 

