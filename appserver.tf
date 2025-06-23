# ---------------------------------------------
# EC2 Instance
# ---------------------------------------------
resource "aws_instance" "app_server" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1.id
  #  associate_public_ip_address = true
  #  key_name = aws_key_pair.tastylog_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              EOF
}

#resource "aws_key_pair" "tastylog_key" {
#  key_name   = "tastylog-dev-keypair"
#  public_key = file("./keys/tastylog-dev-keypair.pub")
#}
