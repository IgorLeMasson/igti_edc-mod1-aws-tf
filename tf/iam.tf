data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com", "glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "glue_role" {
  name                = "glue_role"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.glue_policy.arn]

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_iam_policy" "glue_policy" {
  name = "glue_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:*", "glue:*", "logs:*", "ec2:*", "cloudwatch:*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
