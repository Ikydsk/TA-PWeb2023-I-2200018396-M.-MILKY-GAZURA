<?php
//fungsi ini tanpa return value dan tanpa parameter
function cetak_genap(){
    for($i = 0; $i < 100; $i++){
        if($i%2==0){
            echo "$i, ";
        }
    }
}

//pemanggilan fungsi
cetak_genap();
?>