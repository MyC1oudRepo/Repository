import boto3
import time

# Create VPC
ec2 = boto3.client('ec2')
vpc_name = 'my-vpc-python'
response = ec2.describe_vpcs(
    Filters = [{'Name':'tag:Name', 'Values': [vpc_name]}]
    )

vpcs = response.get('Vpcs', [])

if vpcs:
    vpc_id = vpcs[0]['VpcId']
    print(f"VPC '{vpc_name}' with Id '{vpc_id}' already exists.")
else:
    vpc_response = ec2.create_vpc(CidrBlock='10.0.0.0/16')
    vpc_id = vpc_response ['Vpc']['VpcId']
    
    time.sleep(5)
    
    ec2.create_tags(Resources = [vpc_id], Tags=[{'Key': 'Name', 'Value': vpc_name}])
    print(f"VPC '{vpc_name}' with Id '{vpc_id}' has been created.")
    
# Create internet gateway
ig_name = 'ig-vpc-python'
response = ec2.describe_internet_gateways(
    Filters = [{'Name':'tag:Name', 'Values': [vpc_name]}]
    )
    
internet_gateways = response.get('InternetGateways', [])

if internet_gateways:
    ig_id = vpcs[0]['InternetGatewayID']
    print(f"VPC '{ig_name}' with Id '{ig_id}' already exists.")
else:
    ig_response = ec2.create_internet_gateway()
    ig_id = ig_response ['InternetGateway']['InternetGatewayId']
    ec2.create_tags(Resources = [ig_id], Tags=[{'Key': 'Name', 'Value': ig_name}])
    ec2.attach_internet_gateway(VpcId=vpc_id, InternetGatewayId=ig_id)
    print(f"Internet Gateway '{ig_name}' with Id '{ig_id}' has been created.")
    
# Create a route table and a public route
rt_response = ec2.create_route_table(VpcId=vpc_id)
rt_id = rt_response['RouteTable']['RouteTableId']
route = ec2.create_route(
    RouteTableId=rt_id,
    DestinationCidrBlock='0.0.0.0/0',
    GatewayId=ig_id
    )
print(f"Route table with Id '{rt_id}' has been created.")  


#Create 3 subnets
subnet_1 = ec2.create_subnet(VpcId=vpc_id, CidrBlock='10.0.1.0/24', AvailabilityZone = 'eu-central-1a')
subnet_2 = ec2.create_subnet(VpcId=vpc_id, CidrBlock='10.0.2.0/24', AvailabilityZone = 'eu-central-1b')
subnet_3 = ec2.create_subnet(VpcId=vpc_id, CidrBlock='10.0.3.0/24', AvailabilityZone = 'eu-central-1c')

print(f"subnet_1 ID = {subnet_1['Subnet']['SubnetId']}, subnet_2 ID = {subnet_2['Subnet']['SubnetId']}, subnet_3 ID = {subnet_3['Subnet']['SubnetId']},")
