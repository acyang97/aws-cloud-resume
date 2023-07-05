data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_file = "${path.module}/lambda/main.py"
  output_path = "${path.module}/lambda/main.zip"
}


resource "aws_lambda_function_url" "url1" {
  filename      = data.archive_file.zip_the_python_code.output_path
  source_code_hash      = data.archive_file.zip_the_python_code.output_base64sha256
  function_name = "getViewsForPage"
  handler = "func.handler"
  runtime = "python3.10"

}