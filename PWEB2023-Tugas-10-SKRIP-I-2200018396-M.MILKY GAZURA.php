<?php
    echo "<i>Tugas 10.2.1 (konversi nilai angka ke huruf)</i><br><br>";
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $nilai = $_POST['nilai'];

        if ($nilai >= 80 ) {
            $keterangan = "A";
        } elseif ($nilai >= 76.25 && $nilai < 79.99) {
            $keterangan = "A-";
        } elseif ($nilai >= 68.75 && $nilai < 76.24) {
            $keterangan = "B+";
        } elseif ($nilai >= 65 && $nilai < 68.74) {
            $keterangan = "B";
        } elseif ($nilai >= 62.50 && $nilai < 64.99) {
            $keterangan = "B-";
        } elseif ($nilai >= 57.50 && $nilai < 62.49) {
            $keterangan = "C+";
        } elseif ($nilai >= 55 && $nilai < 57.49) {
            $keterangan = "C";
        } elseif ($nilai >= 51.25 && $nilai < 54.99) {
            $keterangan = "C-";
        } elseif ($nilai >= 43.75 && $nilai < 51.24) {
            $keterangan = "D+";
        } elseif ($nilai >= 40 && $nilai < 43.74) {
            $keterangan = "D";
        } elseif ($nilai >= 0 && $nilai < 39.99) {
            $keterangan = "E";
        }
    } else {
        $nilai = "";
        $keterangan = "";
    }
?>

<!DOCTYPE html>
<html>
<body>
    <form method="POST" action="">
        Nilai: <input type="number" name="nilai" value="<?php echo $nilai; ?>">
        <input type="submit" value="Submit">
    </form>

    <?php if ($_SERVER['REQUEST_METHOD'] === 'POST'): ?>
        <p>Nilai Anda <?php echo $nilai; ?><br> Nilai Anda dalam huruf <?php echo $keterangan; ?></p>
    <?php endif; ?>
</body>
</html>


<br><br>

<?php
    echo "<i>Tugas 10.2.2 (konversi skrip Javascript ke PHP)</i><br><br>";
    $baris = $i = $j = 0;
    $nilai = $tinggi = 5;
    $tinggi = intval($nilai);

    for ($baris = 1; $baris <= $tinggi; $baris++) {
        for ($i = 1; $i <= $tinggi - $baris; $i++) {
            echo "&nbsp; ";
        }
        for ($j = 1; $j < 2 * $baris; $j++) {
            echo "*";
        }
        echo "<br>";
    }
?>