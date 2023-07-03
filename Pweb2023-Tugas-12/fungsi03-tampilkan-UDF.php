<?php
//Fungsi dengan return value dan parameter
function volume_kubus($sisi){
    return $sisi*$sisi*$sisi;
}

$arr=get_defined_functions();
echo "<pre>";
print_r($arr);
echo "</pre>";
?>