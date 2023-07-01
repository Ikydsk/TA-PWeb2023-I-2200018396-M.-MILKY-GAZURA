<?php
    if (isset($_POST['Pilih'])) {
        $esports = $_POST['esports'];
        echo "E-Sports yang Anda pilih adalah : <b><font color='blue'>$esports</font></b>";
    }