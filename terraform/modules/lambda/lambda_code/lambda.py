# import json
# #import boto3

# def lambda_handler(event,context):
#     # dynamodb = boto3.resource('dynamodb')
#     # table = dynamodb.Table('users')
#     # response = table.get_item(Key={'username': event['username']})
#     return {
#         'statusCode': 200,
#         'body': json.dumps(event['headers']['X-Forwarded-For'])
#     }

import json

def lambda_handler(event,context):
    return {
        'statusCode': 200,
        'body': json.dumps("hello-It Works!!!")
    }
    