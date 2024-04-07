resource "aws_iam_policy" "master_policy" {
  name   = "${var.kubernetes_name}-master"
  policy = file("templates/master_policy.json")
}

resource "aws_iam_role" "master_role" {
  name               = "${var.kubernetes_name}-master"
  assume_role_policy = file("templates/iam_role.json")
}

resource "aws_iam_role_policy_attachment" "master_attachment" {
  role       = aws_iam_role.master_role.name
  policy_arn = aws_iam_policy.master_policy.arn
}

resource "aws_iam_instance_profile" "master_profile" {
  name = "${var.kubernetes_name}-master"
  role = aws_iam_role.master_role.name
}

resource "aws_iam_policy" "worker_policy" {
  name   = "${var.kubernetes_name}-worker"
  policy = file("templates/worker_policy.json")
}

resource "aws_iam_role" "worker_role" {
  name               = "${var.kubernetes_name}-worker"
  assume_role_policy = file("templates/iam_role.json")
}

resource "aws_iam_role_policy_attachment" "worker_attachment" {
  role       = aws_iam_role.worker_role.name
  policy_arn = aws_iam_policy.worker_policy.arn
}

resource "aws_iam_instance_profile" "worker_profile" {
  name = "${var.kubernetes_name}-worker"
  role = aws_iam_role.worker_role.name
}