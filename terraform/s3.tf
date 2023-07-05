resource "aws_s3_bucket" "cloudResumeS3Bucket" {
  bucket = "cy-resume-2"

  tags = {
    Name = "aws-cloud resume challenge"
  }
}

resource "aws_s3_bucket_website_configuration" "s3WebsiteConfig" {
  bucket = aws_s3_bucket.cloudResumeS3Bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  # unsure what this is for
  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}
# https://stackoverflow.com/questions/76419099/access-denied-when-creating-s3-bucket-acl-s3-policy-using-terraform
resource "aws_s3_bucket_public_access_block" "s3_access" {
  bucket = aws_s3_bucket.cloudResumeS3Bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

## Bucket policy
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.cloudResumeS3Bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:DeleteObject",
    ]

    resources = [
      aws_s3_bucket.cloudResumeS3Bucket.arn,
      "${aws_s3_bucket.cloudResumeS3Bucket.arn}/*",
    ]
  }
  depends_on = [ aws_s3_bucket_public_access_block.s3_access ]
}

# Does not matter as will be uploaded on push to github via cicd
resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.cloudResumeS3Bucket.id
  key    = "index.html"
  source = "/Users/chunyang/Desktop/personal-projects/aws-cloud-resume/static/index.html"
  etag = filemd5("/Users/chunyang/Desktop/personal-projects/aws-cloud-resume/static/index.html")
}

resource "aws_s3_bucket_object" "error_html" {
  bucket = aws_s3_bucket.cloudResumeS3Bucket.id
  key    = "error.html"
  source = "/Users/chunyang/Desktop/personal-projects/aws-cloud-resume/static/error.html"
  etag = filemd5("/Users/chunyang/Desktop/personal-projects/aws-cloud-resume/static/error.html")
}

resource "aws_s3_bucket_object" "main_css" {
  bucket = aws_s3_bucket.cloudResumeS3Bucket.id
  key    = "main.css"
  source = "/Users/chunyang/Desktop/personal-projects/aws-cloud-resume/static/main.css"
  etag = filemd5("/Users/chunyang/Desktop/personal-projects/aws-cloud-resume/static/main.css")
}

resource "aws_s3_bucket_object" "main-js" {
  bucket = aws_s3_bucket.cloudResumeS3Bucket.id
  key    = "main.js"
  source = "/Users/chunyang/Desktop/personal-projects/aws-cloud-resume/static/main.js"
  etag = filemd5("/Users/chunyang/Desktop/personal-projects/aws-cloud-resume/static/main.js")
}