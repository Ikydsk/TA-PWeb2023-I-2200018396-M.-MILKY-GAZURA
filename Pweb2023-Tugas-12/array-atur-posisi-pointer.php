<?php
$transportasi=array("Mobil","Motor","Sepeda","Becak","Bajaj");
echo "<pre>";
print_r($transportasi);
echo "</pre>";
$mode=current($transportasi);
echo $mode."<br>";
$mode=next($transportasi);
echo $mode."<br>";
$mode=current($transportasi);
echo $mode."<br>";
$mode=prev($transportasi);
echo $mode."<br>";
$mode=end($transportasi);
echo $mode."<br>";
$mode=current($transportasi);
echo $mode."<br>";
?>