# Define the provider and region
provider "aws" {
  access_key = ""
  secret_key = ""
  # Replace with your desired AWS region
  region = "us-east-1"  
}

# Data source to retrieve an existing VPC
data "aws_vpc" "existing_vpc" {
  id = "vpc-0c55f19fa002ee274"  # Replace with the ID of your existing VPC
}

# Data source to retrieve an existing subnet
data "aws_subnet" "existing_subnet1" {
  # Replace with the ID of your existing subnet
  id = "subnet-0f34dce27312ba3fe"  
}

 # Data source to retrieve an existing subnet
 data "aws_subnet" "existing_subnet2" {
   # Replace with the ID of your existing subnet
   id = "subnet-0bbc2ffd333a2a19d"  
 }

 # Data source to retrieve an existing subnet
 data "aws_subnet" "existing_subnet3" {
   # Replace with the ID of your existing subnet
   id = "subnet-0fabec0f207b3527b"  
 }

# Data source to retrieve an existing security group
data "aws_security_group" "existing_sg" {
  # Replace with the name of your existing security group
  id = "sg-0c3dd472b3163cb37"  
}

# Create the second EC2 instance in the existing subnet
resource "aws_instance" "instance1" {
  # Replace with your desired AMI ID
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  # Reference the existing subnet
  subnet_id     = data.aws_subnet.existing_subnet1.id  
  security_groups = [data.aws_security_group.existing_sg.id]
  # Replace with your SSH key pair name
  key_name      = "D6_keypair"
  # Specify the desired availability zone
  availability_zone = "us-east-1a"
  user_data = "${file("s_jenkins.sh")}"

  tags = {
    Name = "D8_Jenkins_EC2"
  }
}

# Create the second EC2 instance in the existing subnet
resource "aws_instance" "instance2" {
  # Replace with your desired AMI ID
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.medium"
  # Reference the existing subnet
  subnet_id     = data.aws_subnet.existing_subnet2.id  
  security_groups = [data.aws_security_group.existing_sg.id]
  # Replace with your SSH key pair name
  key_name      = "D6_keypair"
  # Specify the desired availability zone
  availability_zone = "us-east-1b"
  user_data = "${file("s_docker.sh")}"

  tags = {
    Name = "D8_Docker_EC2"
  }
}

# Create the second EC2 instance in the existing subnet
resource "aws_instance" "instance3" {
  # Replace with your desired AMI ID
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  # Reference the existing subnet
  subnet_id     = data.aws_subnet.existing_subnet3.id  
  security_groups = [data.aws_security_group.existing_sg.id]
  # Replace with your SSH key pair name
  key_name      = "D6_keypair"
  # Specify the desired availability zone
  availability_zone = "us-east-1c"
  user_data = "${file("s_terraform.sh")}"

  tags = {
    Name = "D8_Agent_EC2"
  }
}