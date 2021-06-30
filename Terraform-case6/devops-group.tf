resource "aws_iam_group" "devops_group" {
    name = "devops_group"
}

resource "aws_iam_group_membership" "devops" {
    name = aws_iam_group.devops_group.name
    users = [
        aws_iam_user.devlos_tester.name
    ]
    group = aws_iam_group.devops_group.name
}