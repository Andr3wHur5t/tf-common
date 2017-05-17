
variable "name" {
  type = "string"
  description = "The name of the CI user to scope."
}

## Create the IAM For the User ##

resource "aws_iam_user" "module_ci_user" {
  name = "ci-${var.name}"
  path = "/third-party/ci/"
}

## Outputs ##

output "name" {
  value = "${aws_iam_user.module_ci_user.name}"
}

output "arn" {
  value = "${aws_iam_user.module_ci_user.arn}"
}

