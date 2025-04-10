terraform {
  required_version = "1.11.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
  region = var.region[terraform.workspace]
}

locals {
  env = terraform.workspace == "default" ? "dev" : terraform.workspace
}

data "aws_caller_identity" "current" {}

module "iam" {
  source          = "./modules/iam"
  role_name       = "lambda-sqs-oracle-role"
}

module "vpc" {
  source          = "./modules/vpc"
  environment     = terraform.workspace
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr[terraform.workspace]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "lb" {
  source      = "./modules/lb"
  lb_name     = var.lb_name
  environment = terraform.workspace
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
}

module "ecs" {
  source      = "./modules/ecs"
  environment = terraform.workspace
}

module "cognito" {
  source      = "./modules/cognito"
  environment = terraform.workspace
}

module "sqs" {
  source = "./modules/sqs"
  queues = [
    {
      name              = "person-queue-${terraform.workspace}"
      max_receive_count = 3
    },
    {
      name              = "chosen-person-queue-${terraform.workspace}"
      max_receive_count = 3
    }
  ]
}

module "apigateway" {
  source                = "./modules/apigateway"
  environment           = terraform.workspace
  cognito_user_pool_arn = module.cognito.user_pool_arn
}

module "dynamodb" {
  source      = "./modules/dynamodb"
  environment = terraform.workspace
}


module "apigateway_deployment" {
  source        = "./modules/apigateway-deployment"
  environment   = terraform.workspace
  rest_api_id   = module.apigateway.rest_api_id
  log_group_arn = module.apigateway.log_group_arn
  depends_on = [
    module.trinity-apigateway,
    module.morpheus-apigateway
  ]
}

module "trinity-ecr" {
  source      = "./modules/trinity-ecr"
  region      = var.region[terraform.workspace]
  environment = terraform.workspace
}

module "trinity-service-ecs" {
  source                  = "./modules/trinity-service-ecs"
  app_name                = "trinity"
  environment             = terraform.workspace
  region                  = var.region[terraform.workspace]
  cluster_id              = module.ecs.cluster_id
  image_uri               = "${module.trinity-ecr.repository_url}:0.0.1-SNAPSHOT"
  subnet_ids              = module.vpc.private_subnet_ids
  vpc_id                  = module.vpc.vpc_id
  lb_listener_arn         = module.lb.listener_arn
  lb_target_group_arn     = module.lb.target_group_arn
  lb_security_group_id    = module.lb.lb_security_group_id
  listener_rule_priority  = 20
  desired_count           = 2
  min_capacity            = 2
  max_capacity            = 4
  cpu                     = 256
  memory                  = 512
  container_port          = 8080

  dynamodb_table_arn      = "arn:aws:dynamodb:${var.region[terraform.workspace]}:${data.aws_caller_identity.current.account_id}:table/person-${terraform.workspace}"

  depends_on = [
    module.trinity-ecr,
    module.ecs
  ]
}

module "trinity-apigateway" {
  source             = "./modules/trinity-apigateway"
  rest_api_id        = module.apigateway.rest_api_id
  resource_parent_id = module.apigateway.root_resource_id
  authorizer_id      = module.apigateway.authorizer_id
  integration_url    = "http://${module.lb.lb_dns_name}"
  environment        = terraform.workspace

  depends_on = [
    module.trinity-service-ecs
  ]
}

module "morpheus-ecr" {
  source      = "./modules/morpheus-ecr"
  region      = var.region[terraform.workspace]
  environment = terraform.workspace
}

module "morpheus-service-ecs" {
  source                  = "./modules/morpheus-service-ecs"
  app_name                = "morpheus"
  environment             = terraform.workspace
  region                  = var.region[terraform.workspace]
  cluster_id              = module.ecs.cluster_id
  image_uri               = "${module.morpheus-ecr.repository_url}:0.0.1-SNAPSHOT"
  subnet_ids              = module.vpc.private_subnet_ids
  vpc_id                  = module.vpc.vpc_id
  lb_listener_arn         = module.lb.listener_arn
  lb_target_group_arn     = module.lb.target_group_arn
  lb_security_group_id    = module.lb.lb_security_group_id
  listener_rule_priority  = 30
  desired_count           = 2
  min_capacity            = 2
  max_capacity            = 4
  cpu                     = 256
  memory                  = 512
  container_port          = 8080

  dynamodb_table_arn      = "arn:aws:dynamodb:${var.region[terraform.workspace]}:${data.aws_caller_identity.current.account_id}:table/person-${terraform.workspace}"

  depends_on = [
    module.morpheus-ecr,
    module.ecs
  ]
}

module "morpheus-apigateway" {
  source             = "./modules/morpheus-apigateway"
  rest_api_id        = module.apigateway.rest_api_id
  resource_parent_id = module.apigateway.root_resource_id
  authorizer_id      = module.apigateway.authorizer_id
  integration_url    = "http://${module.lb.lb_dns_name}"
  environment        = terraform.workspace

  depends_on = [
    module.morpheus-service-ecs
  ]
}