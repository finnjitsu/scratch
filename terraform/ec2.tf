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
    Name              = "scratch-app-worker-01"
    ScheduledDowntime = var.scheduled_downtime
    StopSchedule      = var.stop_schedule
    StartSchedule     = var.start_schedule
  }
}