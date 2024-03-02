<strong> The aim of this project is to send emails on a regular schedule using AWS Services. </strong>

For this serverless project I'm using the following services:
- Amazon Simple Email Service (SES)
- AWS Lambda
- Amazon Simple Storage Service (S3)
- Amazon EventBridge (SES)
- AWS Identity & Access Management (IAM)

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/e77871c7-38c7-44a2-9a9e-1716bd4cb812)

The following diagram represents the overview of the final design.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/d653f053-341b-4b44-88f5-ebb9359e57ca)


First, we'll create a bucket:

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/b6a28ece-05ba-4c9a-983f-d1cf9be4c499)


Create an email template. The template email_template.html has been uploaded to this folder.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/56b34a12-a47e-4837-9b83-72a7f5f5060c)


Create a contacts.csv file with the name and email address to be validated.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/593edbe8-fb07-4feb-be0c-c94c43eb58d6)


Update both files email_template.html and contacts.csv to the S3 bucket my-serverless-email-project.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/5dfbecc4-4cfc-4f7f-8b50-b0bb7d7f94bf)


Create an email service by adding your email address and sending domain.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/dd39cca7-5454-4a9d-bc8b-01cbac6cb9df)


Check the mail box and authorize the email address that we are going to use to send emails from.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/56bafbf1-65ce-49ae-b87a-a7cf1e8350f3)


Once you validate your email address you can start sending emails from that address. 

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/08e78764-1199-46bf-a0b0-1e4f5c42bdfc)


From the Amazon SES service, option "Get set up", we can send a test email.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/6b0c51b4-cb6d-45fd-813e-f6f135bdc3f0)


Validate the individual email addresses we want to send to by clicking on "View all identities".

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/63dbd703-711f-44b0-8af8-67ed6bd80714)


Create an identity.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/aaf1aef0-3d5b-4abe-af11-bf2f43f2a108)


Add an email address you want to use to send emails through Amazon SES.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/d6faa679-666f-4575-8db9-bc8d10841c9a)


Confirm by clicking the email validation link.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/a9b1e881-b04a-46b4-a93a-8f389bd24715)


Now we can start sending emails to that email address.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/b823c447-bb09-4aa3-8bbd-64210cf7f6e1)


Next, new are goint to merge the email template with the contacts and then send them to SES throught a Lambda function.

Create a Lambda function from scratch and call it SendSESEmailToContacts. The language I'm using to write my funtion is Python 3.12.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/b80dc182-e38b-4627-8c9f-4ea4cd7df977)


Choose a role that gives permissions to do things on other services and create the function.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/0c297cc1-ef54-483e-9157-7e94f45e007e)


Now we've got the SendSESEmailToContacts function created.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/542b7f7e-9387-452a-a17f-e777f4d31d0f)

Replace the default lambda function with the one from the file lambda_function.py and update line 10 with your bucket name and line 30 with your verified "From" email.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/6f9cf99d-042a-4997-a829-26256a5c19d6)


Deploy the function.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/533c0ed4-95be-47d9-b258-872de3342ae2)


Test the function, just as a check before we trigger it from an external source. Click on Test and configure a test event.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/01ef8004-6441-49d6-bde0-21cfdeef364c)


I called the Event name TestSendEmail.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/01ceea8e-bd20-48f6-a12b-403041424c8a)

I used a simple generic test event. We don't have to pass in the name of the contacts file or the name of the html file, since all this information is hardcoded in the lambda function. Copy the test code from the lambda_function_event_test.py file and save the test.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/3398d0bf-98a5-4310-bdf6-e15ec368c965)

Click on the Test button. We'll get an access denied error code.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/e46e7a8f-3748-49ad-bdd5-b57dbffeba9d)

Search for the lambda execution role. 

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/7c9bea71-5035-493a-ac6a-26d854c20f2e)

Expand the role. We can see that we only have permissions to write to CloudWatch Logs. 

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/c54a9c6d-a2c1-4273-b9ad-708ba6edb0e9)

We have to manually add permissions for S3 and SES. First, we'll create a new policy with those permissions and then we'll attach it to lambda execution role. You can find the policy code in the IAM_Policy_for_SES_and_S3_permissions.json file. Make sure you set the correct bucket name.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/6b1700d5-cd37-4625-849c-7703165d0712)

We'll call the policy LambdaS3SESPolicy and we'll create it leaving the other options by default.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/cb083293-72b5-48df-a77a-948ccd830772)

Go backup to Lambda execution role and add the new policy containing the S3 and SES permissions.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/6c03d558-af26-4bc3-bc59-5d57954ca209)



