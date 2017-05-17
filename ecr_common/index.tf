
variable "name" {
  type = "string"
  description = "The name of the ECR Repository to make"
}

# Create Repo #

resource "aws_ecr_repository" "module_ecr" {
  name = "${var.name}"
}

# Create Common Policies #

resource "aws_iam_policy" "read_module_ecr" {
  name        = "${var.name}-ecr-read-only"
  path        = "/ecr/"
  description = "Read Only Privileges to the ${var.name} ECR repo"

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
		"Effect": "Allow",
		"Action": [
			"ecr:BatchCheckLayerAvailability",
			"ecr:GetDownloadUrlForLayer",
			"ecr:GetRepositoryPolicy",
			"ecr:DescribeRepositories",
			"ecr:ListImages",
			"ecr:DescribeImages",
			"ecr:BatchGetImage"
		],
		"Resource": "${aws_ecr_repository.module_ecr.arn}"
	}, {
    "Effect": "Allow",
    "Action": [
      "ecr:GetAuthorizationToken"
    ],
    "Resource": "*"
  }]
}
EOF
}

resource "aws_iam_policy" "write_module_ecr" {
  name        = "${var.name}-ecr-publish"
  path        = "/ecr/"
  description = "Publish Privileges to the ${var.name} ECR repo"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Sid": "UploadDockerImagesToECR",
    "Effect": "Allow",
    "Action": [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ],
    "Resource": "*"
    }
  ]
}
EOF
}

## Outputs ##

output "publish_policy_arn" {
  value = "${aws_iam_policy.write_module_ecr.arn}"
}

output "read_only_policy_arn" {
  value = "${aws_iam_policy.read_module_ecr.arn}"
}

output "repo_arn" {
  value = "${aws_ecr_repository.module_ecr.arn}"
}

output "repo_url" {
  value = "${aws_ecr_repository.module_ecr.repository_url}"
}

