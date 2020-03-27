resource "aws_cloudwatch_event_rule" "stop_app_worker" {
  name                = "${var.stack_name}-stop-app-worker"
  description         = "Stop the app worker."
  schedule_expression = "cron(${var.stop_schedule})"
  is_enabled           = var.scheduled_downtime
  tags = {
    Name               = "${var.stack_name}-stop-app-worker"
  }
}

resource "aws_cloudwatch_event_rule" "start_app_worker" {
  name                = "${var.stack_name}-start-app-worker"
  description         = "Start the app worker."
  schedule_expression = "cron(${var.start_schedule})"
  is_enabled           = var.scheduled_downtime
  tags = {
    Name               = "${var.stack_name}-start-app-worker"
  }
}

resource "aws_cloudwatch_event_target" "stop_app_worker" {
  target_id = "${var.stack_name}-stop-app-worker"
  arn       = "arn:aws:ssm:us-east-2::document/AWS-StopEC2Instance"
  rule      = "${aws_cloudwatch_event_rule.stop_app_worker.name}"
  role_arn  = "${aws_iam_role.app_worker_role.arn}"
  run_command_targets {
    key    = "InstanceIds"
    values = [
      "${aws_instance.app_worker_01.id}"
    ]
  }
}

resource "aws_cloudwatch_event_target" "start_app_worker" {
  target_id = "${var.stack_name}-start-app-worker"
  arn       = "arn:aws:ssm:us-east-2::document/AWS-StopEC2Instance"
  rule      = "${aws_cloudwatch_event_rule.start_app_worker.name}"
  role_arn  = "${aws_iam_role.app_worker_role.arn}"
  run_command_targets {
    key    = "InstanceIds"
    values = [
      "${aws_instance.app_worker_01.id}"
    ]
  }
}