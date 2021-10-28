resource "aws_ebs_volume" "my_volume" {
    availability_zone = aws_instance.webserver.availability_zone
    size              = 1
    tags = {
        Name = "webserver-pd"
    }
}

resource "aws_volume_attachment" "ebs_attachment" {
    device_name = "/dev/xvdf"
    volume_id   =  aws_ebs_volume.my_volume.id
    instance_id = aws_instance.webserver.id
    force_detach =true     
   depends_on=[ aws_ebs_volume.my_volume,aws_ebs_volume.my_volume]
}
