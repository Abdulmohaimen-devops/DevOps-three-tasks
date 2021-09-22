# This resource will add the key that exist in the dir that his pth will be defined in the variable "PATH_TO_PUBLIC_KEY"
# Please add the public key only
resource "aws_key_pair" "mykeypair" {
  key_name = "mykeypair"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
