provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"

}

# Cluster
resource "aws_ecs_cluster" "aws-ecs-cluster-be" {
  name = "ecom-cluster-be"
  tags = {
    Name = "Ecom-Back-ecs"
  }
}

resource "aws_cloudwatch_log_group" "log-group-be" {
  name = "/ecs/ecom-logs-be"

  tags = {
    Application = "ecom-app-be"
  }
}

# Task Definition

resource "aws_ecs_task_definition" "aws-ecs-task-be" {
  family = "Ecom-task-be"

  container_definitions = <<EOF
  [
  {
      "name": "Ecom-container-be",
      "image": "saragurunglabs01/backend:01",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/ecom-logs-be",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "containerPort": 8000
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
resource "aws_ecs_service" "aws-ecs-service-be" {
  name                 = "Ecom007-ecs-service-be"
  cluster              = aws_ecs_cluster.aws-ecs-cluster-be.id
  task_definition      = aws_ecs_task_definition.aws-ecs-task-be.arn
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets = [
      aws_subnet.private_a.id,
      aws_subnet.private_b.id
    ]
    assign_public_ip = false
    security_groups  = [aws_security_group.ingress_app_be.id]
  }


}