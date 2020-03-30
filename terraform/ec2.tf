/*******************************************************************************
*                                                                              *
* EC2 Instances                                                                *
*                                                                              *
*******************************************************************************/

data "aws_ami" "amzn2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = [ "amzn2-ami-hvm-2*" ]
  }

  filter {
    name   = "virtualization-type"
    values = [ "hvm" ]
  }

  owners = [ "137112412989" ] # Amazon

}

resource "aws_instance" "app_worker_01" {
  ami                    = data.aws_ami.amzn2.id
  instance_type          = "t3.micro"
  availability_zone      = "${var.region}a"
  subnet_id              = module.main_vpc.app_subnet_a_id
  tags = {
    Name                             = "${var.stack_name}-app-worker-01"
    "${var.scheduled_downtime_flag}" = var.scheduled_downtime_enabled
    StopSchedule                     = var.stop_schedule
    StartSchedule                    = var.start_schedule
  }
}

/*******************************************************************************
*                                                                              *
* Security groups                                                              *
*                                                                              *
*******************************************************************************/

resource "aws_security_group" "scratch_egress" {
  name        = "${var.stack_name}-scratch-egress-sg"
  description = "Allow traffic out."
  vpc_id      = module.main_vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    ipv6_cidr_blocks = [
      "::/0"
    ]
  }
}