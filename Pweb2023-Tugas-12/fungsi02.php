<?php
//fungsi ini dengan return value dan parameter
function cetak_genap($awal,$akhir){
    for($i = $awal; $i < $akhir; $i++){
        if($i%2==0){
            echo "$i, ";
        }
    }
}

//pemanggilan fungsi
$a=10;
$b=80;
echo "<b>Bilangan Genap dari $a sampai $b, adalah : </b><br>";
cetak_genap($a,$b);
?>