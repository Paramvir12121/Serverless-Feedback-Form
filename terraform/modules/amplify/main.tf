resource "aws_amplify_app" "my_app" {
  name         = var.app-name
  repository   = var.amplify_repository
  tags         = var.tags
  access_token = var.github_access_token
  //oauth_token = "your-github-oauth-token"
  custom_rule {
    source = "/<*>"
    status = "200"
    target = "./index.html"
  }
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.my_app.id
  branch_name = "main"
}


