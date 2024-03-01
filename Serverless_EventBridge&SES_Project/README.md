<strong> The aim of this project is to send emails on a regular schedule using AWS Services. </strong>

For this serverless project I'm using the following services:
- Amazon Simple Email Service (SES)
- AWS Lambda
- Amazon Simple Storage Service (S3)
- Amazon EventBridge (SES)
- AWS Identity & Access Management (IAM)

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/e77871c7-38c7-44a2-9a9e-1716bd4cb812)


Create a bucket:

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/de7bf8b3-e97c-4025-bf65-b4e176685ca9)


Architecture overview after completing the first step:

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/8eb5bd68-0b82-4aa4-99f4-50897f1c9888)


Create an email template. The template email_template.html has been uploaded to this folder.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/56b34a12-a47e-4837-9b83-72a7f5f5060c)


Create a contacts.csv file with the name and email address to be validated.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/593edbe8-fb07-4feb-be0c-c94c43eb58d6)



Update both files email_template.html and contacts.csv to the S3 bucket my-serverless-email-project.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/5dfbecc4-4cfc-4f7f-8b50-b0bb7d7f94bf)


Create an email service by adding your email address and sending domain.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/dd39cca7-5454-4a9d-bc8b-01cbac6cb9df)


Check the mail box and authorize the email address for use with Amazon SES by accesing the validation URL.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/56bafbf1-65ce-49ae-b87a-a7cf1e8350f3)


Once you validate your email address you can start sending emails from that address. 

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/08e78764-1199-46bf-a0b0-1e4f5c42bdfc)


Our architecture overview at this point will be like this:

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/12570310-f642-4ac8-978d-5410e23b1a01)


From the Amazon SES service, option "Get set up", we can send a test email.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/6b0c51b4-cb6d-45fd-813e-f6f135bdc3f0)


Validate the individual email addresses we want to send to by clicking on "View all identities".

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/63dbd703-711f-44b0-8af8-67ed6bd80714)


Create an identity.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/aaf1aef0-3d5b-4abe-af11-bf2f43f2a108)


Add an email address you want to use to send emails through Amazon SES.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/d6faa679-666f-4575-8db9-bc8d10841c9a)


Confirm by clicking the email validation link.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/2373db97-c7bd-480b-af0a-fd43cbc35bbb)


Now we can start sending emails to that email address.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/b823c447-bb09-4aa3-8bbd-64210cf7f6e1)



