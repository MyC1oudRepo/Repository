<strong> The aim of this project is to send emails on a regular schedule using AWS Services. </strong>

For this serverless project I'm using the following services:
- Amazon Simple Email Service (SES)
- AWS Lambda
- Amazon Simple Storage Service (S3)
- Amazon EventBridge (SES)
- AWS Identity & Access Management (IAM)

  ![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/7a38170b-60b3-4d76-a007-8dafdb1de866)


Create a bucket:

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/de7bf8b3-e97c-4025-bf65-b4e176685ca9)


Architecture overview after completing the first step:

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/a695b6df-0e91-400c-9456-c939d98f60e7)


Create an email template. The template email_template.html has been uploaded to this folder.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/56b34a12-a47e-4837-9b83-72a7f5f5060c)


Create a contacts.csv file with the name and email address to be validated.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/8e3a2ee6-fc12-4034-921f-6632d98a164b)


Update both files email_template.html and contacts.csv to the S3 bucket my-serverless-email-project.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/5dfbecc4-4cfc-4f7f-8b50-b0bb7d7f94bf)


Create an email service by adding your email address and sending domain.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/dd39cca7-5454-4a9d-bc8b-01cbac6cb9df)


Check the email box and authorize this email address for use with Amazon SES by accesing the validation URL.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/af23c610-8c07-471f-8e70-e6eaf9dcd9ae)


Once you validate your email address you can start email sending from that address. 

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/03ac1b6a-4e24-49f1-9f55-09a33fe79f34)

