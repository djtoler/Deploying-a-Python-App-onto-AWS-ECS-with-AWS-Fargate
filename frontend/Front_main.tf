provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"

}

# Cluster
resource "aws_ecs_cluster" "aws-ecs-cluster-fe" {
  name = "ecom-cluster-fe"
  tags = {
    Name = "Ecom-Front-ecs"
  }
}

resource "aws_cloudwatch_log_group" "log-group-fe" {
  name = "/ecs/ecom-logs-fe"

  tags = {
    Application = "ecom-app-fe"
  }
}

# Task Definition

resource "aws_ecs_task_definition" "aws-ecs-task-fe" {
  family = "Ecom-task-fe"

  container_definitions = <<EOF
  [
  {
      "name": "Ecom-container-fe",
      "image": "djtoler/fetest1dp8:latest",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/ecom-logs-fe",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "containerPort": 3000
        }
      ]
    }
  ]
  EOF

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = "arn:aws:iam::860933984029:role/ecsTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::860933984029:role/ecsTaskExecutionRole"

}

# ECS Service
resource "aws_ecs_service" "aws-ecs-service-fe" {
  name                 = "Ecom007-ecs-service-fe"
  cluster              = aws_ecs_cluster.aws-ecs-cluster-fe.id
  task_definition      = aws_ecs_task_definition.aws-ecs-task-fe.arn
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 2
  force_new_deployment = true

  network_configuration {
    subnets = [
      aws_subnet.private_a.id,
      aws_subnet.private_b.id
    ]
    assign_public_ip = false
    security_groups  = [aws_security_group.ingress_app_fe.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecom-app-fe.arn
    container_name   = "Ecom-container-fe"
    container_port   = 3000
  }

}