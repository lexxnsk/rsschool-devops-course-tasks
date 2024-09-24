# main.tf

terraform {
  backend "s3" {
    bucket         = "amyslivets.terraform-state-s3-bucket"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "amyslivets.terraform-state-lock-table" # Optional: For state locking
  }
}