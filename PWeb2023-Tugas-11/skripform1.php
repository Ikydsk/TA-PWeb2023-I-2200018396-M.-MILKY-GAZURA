<html>
<head>
    <title>PENGOLAHAN FORM CARA 1</title></head>
    <body>
        <form action="" method="post" name="input">
            Nama Anda : <input type="text" name="nama"><br>
            <input type="submit" name="Input" value="Tampilkan isi TextBox"/>
        </form>
    </body>
</html>

<?php
    if (isset($_POST['Input'])) {
        $nama = $_POST['nama'];
        echo "Nama Anda : <b>$nama</b>";
    }