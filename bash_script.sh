#! /bin/bash
cd /terraform
terraform init
echo "Starting terraform Deployemnt"
terraform apply -auto-approve -target=module.api_gateway_lambda -target=module.dynamodb-feedback
# terraform_output=$(terraform output -json)
# echo "$terraform_output" > /path/to/your/website/output.json
# terraform apply -auto-approve -target=module.s3_bucket_webpages

