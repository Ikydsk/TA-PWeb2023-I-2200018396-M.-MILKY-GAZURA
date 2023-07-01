<html>
<head>
    <style>
        .error {
            color: #FF0000;
        }
    </style>
    <head>
    </body>
    <?php
    // define variables and set to empty values
    $namaErr = $emailErr = $genderErr = $websiteErr = "";
    $nama = $email = $gender = $comment = $website = "";

    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        if (empty($_POST["nama"]))
        {
            $namaErr = "Nama harus diisi";
        }
        else
        {
            $nama = test_input($_POST["nama"]);
            // check if name only contains letters and whitespace
            if (!preg_match("/^[a-zA-Z ]*$/",$nama))
            {
                $namaErr = "Hanya huruf dan spasi yang diperbolehkan";
            }
        }
        if (empty($_POST["email"]))
        {
            $emailErr = "Email harus diisi";
        }
        else
        {
            $email = test_input($_POST["email"]);
            // check if e-mail address is well-formed
            if (!filter_var($email, FILTER_VALIDATE_EMAIL))
            {
                $emailErr = "Format email invalid";
            }
        }
        if (empty($_POST["website"]))
        {
            $website = "";
        }
        else
        {
            $website = test_input($_POST["website"]);
            // check if URL address syntax is valid (this regular expression also allows dashes in the URL)
            if (!preg_match("/\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i",$website))
            {
                $websiteErr = "URL tidak valid";
            }
        }
        if (empty($_POST["comment"]))
        {
            $comment = "";
        }
        else
        {
            $comment = test_input($_POST["comment"]);
        }
        if (empty($_POST["gender"]))
        {
            $genderErr = "Gender harus dipilih";
        }
        else
        {
            $gender = test_input($_POST["gender"]);
        }
    }
    function test_input($data)
    {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data); return $data;
    }
    ?>

    <h2>
        Contoh Validasi Form dengan PHP
    </h2>
    <p><span class="error">* Harus Diisi.</span></p>

    <form method="post" action="<?php htmlspecialchars($_SERVER["PHP_SELF"]);?>">
    Name: <input type="text" name="nama" value="<?php echo $nama;?>">  
    <span class="error">* <?php echo $namaErr;?></span>
    <br><br>
    E-mail: <input type="text" name="email" value="<?php echo $email;?>">
    <span class="error">* <?php echo $emailErr;?></span>
    <br><br>
    Website: <input type="text" name="website" value="<?php echo $website;?>">
    <span class="error"><?php echo $websiteErr;?></span>
    <br><br>
    Comment: <textarea name="comment" rows="5" cols="40"><?php echo $comment;?></textarea>
    <br><br>
    Gender : 
    <input type="radio" name="gender" <?php
    if (isset($gender) && $gender=="Laki-laki") echo "checked";?> value="Laki-laki">Laki-laki
    <input type="radio" name="gender" <?php
    if (isset($gender) && $gender=="Perempuan") echo "checked";?> value="Perempuan">Perempuan
    <span class="error">* <?php echo $genderErr;?></span>
    <br><br>
    <input type="submit" name="submit" value="Submit">
    </form>

    <?php
    echo "<h2>Data yang anda isi:</h2>";
    echo "<table border='1'>";
    echo "<tr>";
    echo "<td>Nama</td>";
    echo "<td>Email</td>";
    echo "<td>Website</td>";
    echo "<td>Comment</td>";
    echo "<td>gender</td>";
    echo "</tr>";
    echo "<tr>";
    echo "<td>$nama</td>";
    echo "<td>$email</td>";
    echo "<td>$website</td>";
    echo "<td>$comment</td>";
    echo "<td>$gender</td>";
    echo "</tr>";
    echo "</table>";
    ?>
    </body>
</html>