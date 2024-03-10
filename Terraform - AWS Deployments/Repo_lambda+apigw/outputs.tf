#--------------------------------------------------------------
# lambda Outputs
#--------------------------------------------------------------

output "teraform_aws_role_output" {
  description = "IAM Lambda role name"
  value       = aws_iam_role.iam_for_lambda.name
}

output "teraform_aws_role_arn_output" {
  description = "IAM Lambda role arn"
  value       = aws_iam_role.iam_for_lambda.arn
}

output "Lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_permission.apigw_lambda.function_name
}