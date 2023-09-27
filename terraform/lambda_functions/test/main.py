import json

def lambda_handler(event,context):
    return {
        'statusCode': 200,
        'body': json.dumps("hello-It Works!!!")
    }


# import boto3

# # Create a client for the STS (Security Token Service)
# sts_client = boto3.client('sts')

# # Retrieve the account ID
# response = sts_client.get_caller_identity()
# account_id = response['Account']

# print("AWS Account ID:", account_id)