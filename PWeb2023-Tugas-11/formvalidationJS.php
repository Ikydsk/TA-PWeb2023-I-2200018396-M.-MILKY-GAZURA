<html>
<head>
    <title>CONTOH FORM VALIDASI DENGAN JAVASCRIPT
     </title>
     <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <center>
            <h2>
                Portal UAD
            </h2>
        </center>  
        <div class="login">
            <form action="#" method="post" onSubmit="return validasi()">
                <div>
                    <label>Nama Lengkap:</label>
                    <input type="text" name="nama" id="nama" />
                </div>
                <div>
                    <label>email:</label>
                    <input type="email" name="email" id="email" />
                </div>      
                <div>
                    <label>Alamat:</label>
                    <textarea cols="40" rows="5" name="alamat" id="alamat">
                    </textarea>
                </div>
                <div>
                    <input type="submit" value="Kirim" class="tombol">
</form>
</div>
</body>
<script type="text/javascript">
    function validasi() {
        var nama = document.getElementById("nama").value;
        var email = document.getElementById("email").value;
        var alamat = document.getElementById("alamat").value;
        if (nama != "" && email!="" && alamat !="") {
            return true;
        }else{
            alert('Anda harus mengisi data dengan lengkap !');
        }
    }
</script>
</html>