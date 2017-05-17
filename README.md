# Common Terraform Modules

# Quick Start

Clone this repo inside of your infrastructure repo.

Use your desired module

```
module "example_ecr_setup_any_name_will_do" {
  source = "./modules/ci_ecr" # Path to cloned repo and desired module

  name = "my-fancy-ci-ecr-setup"
}

```

# Modules:

- `ci_ecr` A AWS elastic container registry (Docker repo) with CI/CD User with a minimal policy that allows publishing an image.
- `ci_user` A simple user tagged to make it easy to audit external access to resources.
- `common_ecr` AWS elastic container registry (Docker repo) with common pre-configured policies like read only and
  publish.

