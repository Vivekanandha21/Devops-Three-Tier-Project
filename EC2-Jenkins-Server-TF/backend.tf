terraform {
  backend "s3" {
    bucket = "jenkins-server-statefile"  # The S3 bucket name
    key    = "Terraform/terraform.tfstate"  # Path and name of the state file within the bucket
    region = "ap-south-1"  # Region where the S3 bucket is located
    encrypt = true  # Enable encryption for the state file
    acl     = "bucket-owner-full-control"  # Permissions for the state file
    dynamodb_table = "terraform-lock-table"  # DynamoDB table for locking
  }
}
   