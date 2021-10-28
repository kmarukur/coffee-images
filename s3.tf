resource "aws_s3_bucket" "task1_s3bucket" {
  bucket = "website-images-coffe-tfedemo"
  acl    = "public-read"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }    
}

resource "null_resource" "images_repo" {
  provisioner "local-exec" {
    command = "git clone https://github.com/kmarukur/coffee-images.git my_images"
  }
  provisioner "local-exec"{ 
  when        =   destroy
        command     =   "rm -rf my_images"
    }
}
resource "aws_s3_bucket_object" "coffee_image" {
  bucket = aws_s3_bucket.task1_s3bucket.bucket
  key    = "coffee1.jpg"
  source = "my_images/coffee1.jpg"
  acl="public-read"
   depends_on = [aws_s3_bucket.task1_s3bucket,null_resource.images_repo]
}
