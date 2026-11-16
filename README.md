### TUGAS 7
1. Widget tree adalah struktur pohon dari semua widget yang ada dalam app, tree ini terdiri dari widget root dan widget child (cabang). Hubungan parent dengan child: parent bertugas untuk membungkus, memberi constraint dan posisi child tersebut, child akan "terbatasi" oleh constraint dari parentnya.

2. - MaterialApp: root dari app,
   - Scaffold: kerangka halaman,
   - AppBar: bar judul di bagian atas,
   - Text: menampilkan teks,
   - Padding: memberi spacing diantara child,
   - Column: menyusun child secara vertikal,
   - Row: menyusun child secara horizontal,
   - Center: menaruh child ke tengah,
   - SizedBox: memberi jarak dengan ukuran tetap,
   - Card: kartu dipakai di InfoCard,
   - Container: wadah yang ukuran dan paddingnya bisa diatur,
   - Material: permukaan Material dengan warna dan sudut melengkung,
   - InkWell: area yang bisa ditekan dengan efek ripple,
   - Icon: menampilkan ikon,
   - GridView.count: menampilkan item dengan jumlah kolom tetap,
   - SnackBar: notifikasi yang muncul saat tombol ditekan,
   - InfoCard dan ItemCard: widget buatan sendiri yang bisa dipakai ulang,

3. MaterialApp adalah widget yang menyediakan konfigurasi dasar aplikasi bergaya Material Design, seperti ThemeData, judul, homepage, dan sistem navigasi. Widget ini umum dipakai sebagai root karena widget Material lain seperti Scaffold, AppBar, dan SnackBar membutuhkan tema dan konteks yang disediakannya agar bisa berfungsi.

4. StatelessWidget tidak punya state yang berubah, tampilannya hanya bergantung pada data yang diterima saat dibuat (ibarat gambar yang diprint di printer tidak akan berubah setelah kita klik tombol print). StatefulWidget punya State object yang bisa berubah, dan UI diperbarui lewat setState(). Karena homepage cenderung statis (tidak banyak perubahan interaktif atau data yang berubah secara dinamis), kita bisa memiilih StatelessWidget untuk halaman menu ini.

5. BuildContext adalah penanda sebuah widget di dalam widget tree. Fungsinya penting karena lewat context, widget bisa mengakses data dari widget di atasnya, seperti Theme.of(context), MediaQuery.of(context), dan ScaffoldMessenger.of(context). Di metode build(BuildContext context), context diberikan otomatis oleh Flutter dan dipakai untuk mengambil informasi tersebut.

6. Hot reload memasukkan perubahan kode ke aplikasi yang sedang berjalan tanpa menghilangkan state, jadi hasilnya terlihat dalam hitungan detik. Hot restart menjalankan ulang aplikasi dari awal sehingga state hilang. Hot reload tidak cukup ketika mengubah main(), nilai variabel global atau static, initState, enum, atau tipe class (misalnya stateless menjadi stateful). Untuk perubahan pada kode native, atau konfigurasi Android/iOS, perlu full restart (stop lalu flutter run lagi).

### AI DISCLOSURE
Saya menggunakan Claude model Sonnet 5.5 untuk membantu saya menjelaskan beberapa pertanyaan reflektif.
https://claude.ai/share/7935a38d-339c-448d-a03d-2204ab8c60f1