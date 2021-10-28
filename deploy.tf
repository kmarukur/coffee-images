resource "null_resource" "nullremote"  {
depends_on = [  aws_volume_attachment.ebs_attachment,aws_cloudfront_distribution.s3_distribution
   ]
    connection {
        type    = "ssh"
        user    = "ec2-user"
        host    = aws_instance.webserver.public_ip
        port    = 22
        private_key  = tls_private_key.webserver_private_key.private_key_pem
    }
   provisioner "remote-exec" {
        inline  = [
     "sudo mkfs.ext4 /dev/xvdf",
     "sudo mount /dev/xvdf /var/www/html",
     "sudo rm -rf /var/www/html/*",
     "sudo git clone https://github.com/kmarukur/coffee-images.git /var/www/html/",
     "sudo su << EOF",
            "echo \"${aws_cloudfront_distribution.s3_distribution.domain_name}\" >> /var/www/html/path.txt",
            "EOF",
     "sudo systemctl restart httpd"
 ]
    }
}
