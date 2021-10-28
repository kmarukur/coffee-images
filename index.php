<html>
<body>
<h1>Good Morning!</h1>
<h5><b>Below image is from cloudfront</b></h5>
<?php
   $firstline=`head -n1 path.txt`;          
   $path_img="https://".$firstline."/coffee2.jpg";
   $path_img="https://".$firstline."/coffee1.jpg";
   echo "<br>";
   echo "<img src='{$path_img}' width=500 height=500>";
?>
</body>
</html>
