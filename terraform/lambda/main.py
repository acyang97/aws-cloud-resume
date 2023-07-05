import boto3
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('aws-cloud-challenge')

def lambda_handler(event, context):
    headers = {
        'Access-Control-Allow-Origin': 'https://www.aws-cloud-resume-challenge-lalala.online',
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type'
    }
    response = table.get_item(Key={ 'id': '1'})
    views = int(response['Item']['views'])
    views+=1
    response = table.put_item(Item={'id': '1', 'views': views})
    return {
        'statusCode': 200,
        'headers': headers,
        'body': json.dumps({'views': views})
    }