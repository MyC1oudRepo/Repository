// Lambda policy document
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

// IAM Lambda assume role policy
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

// Upload lambda function
data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/lambda_function.zip"
}

// Create a lambda function
# In terraform ${path.module} is the current directory.
resource "aws_lambda_function" "lambda_function" {
  filename      = "${path.module}/python/lambda_function.zip"
  function_name = "LambdaFunctionterraform"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  #depends_on                    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}