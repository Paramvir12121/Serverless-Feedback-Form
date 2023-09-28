resource "aws_dynamodb_table" "feedback" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "FeedbackID"
  attribute {
    name = "FeedbackID"
    type = "S"
  }
#   attribute {
#     name = "Name"
#     type = "S"
#   }
#   attribute {
#     name = "Email"
#     type = "S"
#   }
#   attribute {
#     name = "FeedbackText"
#     type = "S"
#   }
}
