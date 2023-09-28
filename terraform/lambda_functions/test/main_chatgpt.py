# import json

# def lambda_handler(event,context):
#     return {
#         'statusCode': 200,
#         'body': json.dumps("hello-It Works!!!")
#     }


import json
import boto3

# Initialize the DynamoDB resource
dynamodb = boto3.resource('dynamodb')
table_name = 'Feedback-table'  # Replace with your DynamoDB table name
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    try:
        # Parse the incoming JSON data
        body = json.loads(event['body'])
        
        # Extract feedback data
        name = body.get('name')
        email = body.get('email')
        feedback_text = body.get('feedback')
        
        # Perform basic input validation
        if not name or not email or not feedback_text:
            return {
                'statusCode': 400,
                'body': json.dumps('Invalid input. Please provide name, email, and feedback.')
            }
        
        # Generate a unique feedback ID (you can customize this logic)
        feedback_id = generate_unique_id(name, email)
        
        # Store feedback data in DynamoDB
        response = table.put_item(
            Item={
                'FeedbackID': feedback_id,
                'Name': name,
                'Email': email,
                'FeedbackText': feedback_text
            }
        )
        
        # Return a success response
        return {
            'statusCode': 200,
            'body': json.dumps('Feedback submitted successfully.')
        }
    
    except Exception as e:
        # Handle any errors and return an error response
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }

def generate_unique_id(name, email):
    # Customize this logic to generate a unique ID based on name and email
    # For simplicity, we concatenate name and email, but you can use a more sophisticated method.
    return f'{name}_{email}'
