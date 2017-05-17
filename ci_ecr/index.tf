
variable "name" {
  type = "string"
  description = "The name to create ECR Repo, Policies, and CI user under."
}

### Create And Link Resources ###

module "ecr" {
  source = "../ecr_common"
  name = "${var.name}"
}

module "ci_user" {
  source = "../ci_user"
  name = "${var.name}"
}

resource "aws_iam_policy_attachment" "publish_image_attach" {
  name       = "publish_image_attachment"
  users      = ["${module.ci_user.name}"]
  policy_arn = "${module.ecr.publish_policy_arn}"
}

### Output ###

output "ci_user_name" {
  value =  "${module.ci_user.name}"
}

output "ci_user_arn" {
  value =  "${module.ci_user.arn}"
}

output "ecr_url" {
  value =  "${module.ecr.repo_url}"
}

output "ecr_arn" {
  value =  "${module.ecr.repo_arn}"
}

output "ecr_read_only_policy_arn" {
  value =  "${module.ecr.read_only_policy_arn}"
}

output "ecr_publish_policy_arn" {
  value =  "${module.ecr.read_only_policy_arn}"
}

