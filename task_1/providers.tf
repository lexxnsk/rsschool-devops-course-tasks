# providers.tf

provider "aws" {
  region = var.aws_region  # Reference the variable here from variables.tf
}