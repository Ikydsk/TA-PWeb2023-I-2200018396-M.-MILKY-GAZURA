<?php
    if (isset($_POST['Pilih'])) {
        $anime = $_POST['anime'];
        echo "Judul Anime Favorit Anda adalah : <font color=orange><b>$anime</b></font>";
    }
?>