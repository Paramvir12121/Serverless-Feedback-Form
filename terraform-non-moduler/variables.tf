locals {
  aws_region = "us-east-1"
  tags = {
    name = "feedback-form"
    env  = "dev"
  }
}
variable "aws_credentials_file_path" {
  description = "Locate the AWS credentials file."
  type        = string
  default     = "C:/Users/param/.ssh/ACS-keys/portfolio-user-1_accessKeys.csv"
}
#bucket & objects
variable "aws_region" {
  description = "Default to US East (N. Virgínia) region."
  default     = "us-east-1"
}
