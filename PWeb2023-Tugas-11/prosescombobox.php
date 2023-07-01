<?php
    if (isset($_POST['Pilih'])) {
        $anime = $_POST['anime'];
        echo "Judul Anime Favorit Anda adalah : <font color=blue><b>$anime</b></font>";
    }
?>