resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}


resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress = []
  egress  = []

  tags = {
    Name = "${var.project_name}-default-sg"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}


resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"

  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-public-a"
  }
}


resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"

  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-public-b"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}


resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}


resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/${var.project_name}-flow-logs"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.cloudwatch.arn

  tags = {
    Name = "${var.project_name}-vpc-flow-logs"
  }
}


data "aws_iam_policy_document" "vpc_flow_logs_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "vpc-flow-logs.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}


resource "aws_iam_role" "vpc_flow_logs" {
  name = "${var.project_name}-vpc-flow-logs-role"

  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_assume_role.json

  tags = {
    Name = "${var.project_name}-vpc-flow-logs-role"
  }
}


resource "aws_iam_role_policy" "vpc_flow_logs" {
  #checkov:skip=CKV_AWS_355:CloudWatch Logs Describe APIs require account-level wildcard access; write permissions remain scoped to the VPC Flow Logs log group.

  name = "${var.project_name}-vpc-flow-logs-policy"
  role = aws_iam_role.vpc_flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "WriteVPCFlowLogs"
        Effect = "Allow"

        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "${aws_cloudwatch_log_group.vpc_flow_logs.arn}:*"
      },
      {
        Sid    = "DescribeCloudWatchLogs"
        Effect = "Allow"

        Action = [
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]

        Resource = "*"
      }
    ]
  })
}


resource "aws_flow_log" "main" {
  vpc_id = aws_vpc.main.id

  traffic_type = "ALL"

  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn

  iam_role_arn = aws_iam_role.vpc_flow_logs.arn

  tags = {
    Name = "${var.project_name}-vpc-flow-log"
  }
}