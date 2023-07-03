<?php
function tambah_string(&$str){
    $str=$str. ", DKI JAKARTA";
    return $str;
}

$string="Universitas Indonesia";
echo "\$string = $string<br>";
echo tambah_string($string). "<br>";
echo "\$string = $string<br>";
?>