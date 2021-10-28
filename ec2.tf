resource "aws_instance" "webserver" {
  ami           = "ami-074cce78125f09d61"
  instance_type = "t2.micro" 
  key_name  = aws_key_pair.webserver_key.key_name
  security_groups=[aws_security_group.allow_http_ssh.name]
tags = {
    Name = "webserver_task1"
  }
  connection {
        type    = "ssh"
        user    = "ec2-user"
        host    = aws_instance.webserver.public_ip
        port    = 22
        private_key = tls_private_key.webserver_private_key.private_key_pem
    }
  provisioner "remote-exec" {
        inline = [
        "sudo yum install httpd php git -y",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        ]
    }
}
