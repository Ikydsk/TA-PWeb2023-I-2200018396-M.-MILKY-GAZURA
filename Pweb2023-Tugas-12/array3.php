<?php
$arrWarna=array("Blue","Black","Red","Pink","Green");

echo "Menampilkan isi array dengan for : <br>";
for($i=0; $i<count($arrWarna); $i++) {
    echo "Warna Pelangi <font color=$arrWarna[$i]>". $arrWarna[$i]. "</font><br>";
}

echo "<br>Menampilkan isi array dengan foreach : <br>";
foreach ($arrWarna as $warna) {
    echo "Warna Pelangi <font color=$warna>". $warna. "</font><br>";
}
?>