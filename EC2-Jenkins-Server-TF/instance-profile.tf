resource "aws_iam_instance_profile" "instance-profile" {
  name = var.iam_instance_profile
  role = aws_iam_role.iam-role.name
}