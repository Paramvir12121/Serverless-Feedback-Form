resource "aws_dynamodb_table" "feedback" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "FeedbackID"
  attribute {
    name = "FeedbackID"
    type = "S"
  }
}

variable "table_name" {
  type = string

}