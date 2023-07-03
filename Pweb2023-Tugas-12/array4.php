<?php
$arrNilai = array("Ani" => 80,  "Otim" => 90,  "Ana" => 75,  "Budi" => 85);
echo "Menampilkan isi array asosiatif dengan foreach : <br>";
foreach ($arrNilai as $nama => $nilai) {
    echo "Nilai $nama=$nilai<br>";
}

echo "<br>Menampilkan isi array dengan while dan list : <br>";
foreach ($arrNilai as $nama => $nilai) {
    echo "Nilai $nama=$nilai<br>";
}
?>
