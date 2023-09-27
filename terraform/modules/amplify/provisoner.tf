# resource "null_resource" "amplify_deploy" {
#     depends_on = [ aws_amplify_app.my_app ]
#   triggers = {
#     amplify_branch_head = aws_amplify_branch.main.id
#   }

#   provisioner "local-exec" {
#     command = "amplify publish --yes" # Execute the amplify publish command
#   }
# }