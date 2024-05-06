"""
This script manges Amazon EC2 instances using Boto3 Python SDK
"""

#import statements
import boto3


# Initialize the EC2 resource and instance name
ec2 = boto3.resource('ec2')

# Define the instance name
instance_name = 'ec2-hol'

# Instance ID
instance_id = None


# check if the instance which I'm trying to create already exists
# and only work with an instance that hasn't been terminated.

instances = ec2.instances.all()

#print(instances)

instance_exists = False

for instance in instances:
    for tag in instance.tags:
        if tag ['Key'] == 'Name' and tag ['Value'] == instance_name:
            instance_exists = True
            instance_id = instance.id
            print(f"An instance named '{instance_name}' with id '{instance_id}' already exists.")
            break
    if instance_exists:
        break

if not instance_exists:
# Launch a new EC2 instance if it hasn't already been created
    new_instance = ec2.create_instances(
        ImageId='ami-098c93bd9d119c051',  # Replace with a valid AMI ID
        InstanceType='t2.micro',  # Replace 't2.micro' with your desired instance type
        MinCount=1,
        MaxCount=1,
        KeyName='Mykeypair',
        TagSpecifications=[
            {
                'ResourceType': 'instance',
                'Tags': [
                    {
                        'Key': 'Name', 
                        'Value': instance_name
                    },
                ]
            },
        ]
    )
    instance_id = new_instance[0].id
    print(f"New instance named '{instance_name}' has been created. Instance ID: {instance_id}")
    

# Stop EC2 instance
#ec2.Instance(instance_id).stop()
#print(f"Instance '{instance_name}' with id '{instance_id}' has been stopped.")

# Start EC2 instance
#ec2.Instance(instance_id).start()
#print(f"Instance '{instance_name}' with id '{instance_id}' has been started.")

# Terminate EC2 instance
ec2.Instance(instance_id).terminate()
print(f"Instance '{instance_name}' with id '{instance_id}' has been terminated.")