<?php
    if (isset($_POST['Login'])) {
        $user = $_POST['username'];
        $pass = $_POST['password'];
        if ($user == "mahasiswa" && $pass == "12345678") {
            echo "<h2>Login Berhasil, Selamat Datang</h2>";
        } else {
            echo "<h2>Username/Password salah, Maaf ulang lagi</h2>";
        }
    }