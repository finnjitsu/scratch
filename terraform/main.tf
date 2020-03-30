provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}

module "main_vpc" {
  source            = "github.com/finnjitsu/aws-vpc"
  region            = var.region
  stack_name        = var.key
  vpc_cidr          = var.vpc_cidr
  app_subnet_a_cidr = var.app_subnet_a_cidr
  app_subnet_b_cidr = var.app_subnet_b_cidr
  db_subnet_a_cidr  = var.db_subnet_a_cidr
  db_subnet_b_cidr  = var.db_subnet_b_cidr
  web_subnet_a_cidr = var.web_subnet_a_cidr
  web_subnet_b_cidr = var.web_subnet_b_cidr
}

module "stop_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_stop"
  cloudwatch_schedule_expression = "cron(${var.stop_schedule})"
  schedule_action                = "stop"
  ec2_schedule                   = "true"
  rds_schedule                   = "false"
  autoscaling_schedule           = "false"
  resources_tag                  = {
    key   = "${var.scheduled_downtime_flag}"
    value = "${var.scheduled_downtime_enabled}"
  }
}