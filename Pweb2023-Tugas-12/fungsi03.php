<?php
//Fungsi dengan return value dan parameter
function volume_kubus($sisi){
    return $sisi*$sisi*$sisi;
}

//pemanggilan fungsi
$s=20;
echo "Volume Kubus dengan sisi $s = ";
echo volume_kubus($s);
?>