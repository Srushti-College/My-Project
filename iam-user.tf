# resource "aws_iam_user" "lb" {
#   name = "terraform"
#   path = "/"

#   tags = {
#     Name = "Terraform"
#   }
# }

# resource "aws_iam_access_key" "lb" {
#   user = aws_iam_user.lb.name
# }

# data "aws_iam_policy_document" "lb_ro" {
#   statement {
#     effect    = "Allow"
#     actions   = ["ec2:Describe*"]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_user_policy" "lb_ro" {
#   name   = "test"
#   user   = aws_iam_user.lb.name
#   policy = data.aws_iam_policy_document.lb_ro.json
# }