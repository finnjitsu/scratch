resource "aws_iam_policy" "app_worker_policy" {
  name        = "${var.stack_name}-app-worker-policy"
  path        = "/serviceRole/"
  description = "Policy for Jenkins services."
  policy      = templatefile("${path.module}/app-worker-policy.tpl",
                             { instance_arn = aws_instance.app_worker_01.arn,
                               region = var.region })
}

resource "aws_iam_role" "app_worker_role" {
  name = "${var.stack_name}-app-worker-role"
  path = "/serviceRole/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "app_worker_instance_profile" {
  name = "${var.stack_name}-app-worker-instance-profile"
  role = aws_iam_role.app_worker_role.name
}

resource "aws_iam_role_policy_attachment" "app_worker_role_app_worker_policy_attachment" {
  role       = aws_iam_role.app_worker_role.name
  policy_arn = aws_iam_policy.app_worker_policy.arn
}

resource "aws_iam_role_policy_attachment" "app_worker_role_ssm_policy_attachment" {
  role       = aws_iam_role.app_worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}