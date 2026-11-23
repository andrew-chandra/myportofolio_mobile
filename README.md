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

### TUGAS 8
1. Naavigator bekerja seperti strukur data stack yang bersifat LIFO (last in first out),
   - Navigator.push() menambahkan route baru di atas stack, halaman sebelumnya tetap ada, sehingga pengguna bisa kembali dengan tombol Back.
   - Navigator.pushReplacement() mengganti route teratas dengan route baru. Halaman lama dibuang dari stack, jadi tidak bisa balik dengan tombol Back.
   - Navigator.pop() menghapus route teratas dari stack, sehingga pengguna kembali ke route di elemen sebelumnya.

   Untuk membuka formulir dari kartu aksi, aplikasi memakai Navigator.push() dengan MaterialPageRoute ke ProjectFormPage atau EducationFormPage. Opsi Home di drawer memakai Navigator.pushReplacement() ke MyHomePage(). Halaman yang sedang muncul cth: formulir akan direplace dengan halaman utama sehingga user langsung tiba di halaman utama dan formulir akan terhapus dari stack.

2. Scaffold menyediakan kerangka halaman yang sama (appBar, drawer, body), sehingga setiap halaman punya struktur yang seragam. AppBar menjaga judul dan warna bagian atas tetap seragam. Drawer dibuat sekali sebagai widget terpisah lalu dipasang di MyHomePage, ProjectFormPage, dan EducationFormPage lewat drawer: const LeftDrawer(). Hasilnya navigasi selalu sama di semua halaman, dan kalau menu drawer diubah, semua halaman ikut berubah. Contoh warna tema: warna Colors.indigo dipakai di AppBar halaman Add Project dan Add Education, di DrawerHeader pada LeftDrawer, dan di tombol Save. Halaman utama memakai Theme.of(context).colorScheme.primary yang berasal dari seedColor: Colors.indigo di main.dart, sehingga warna dominan antar halaman terlihat seragam.

3. Formulir disusun dengan urutan Form, SingleChildScrollView, Padding, Column. Column dipilih karena field diisi berurutan dari atas ke bawah, dan crossAxisAlignment.start akan menyesuaikan posisi. Padding memberi jarak antar field supaya tidak menempel. SingleChildScrollView penting ketika ruang layar terbatas, misalnya di layar sempit atau saat keyboard muncul dan menutupi sebagian layar. Column sendiri tidak bisa discroll, sehingga tanpa pembungkus ini konten bisa overflow dan tombol Save tidak terjangkau. Dengan scroll, pengguna tetap bisa menggulir ke semua input dan tombol Simpan.

4. 
GlobalKey<FormState> (_formKey) dipasang pada widget Form sebagai pengenal, sehingga kita bisa mengakses state form dari luar, misalnya memanggil _formKey.currentState!.validate() dan reset(). validator adalah fungsi pada tiap field yang mengembalikan pesan error bila input tidak sesuai aturan, atau null bila valid, validate() dipanggil saat tombol save ditekan. Fungsi ini menjalankan semua validator, menampilkan pesan error pada field yang bermasalah, dan mengembalikan true hanya jika semua input valid. Dialog ringkasan ditampilkan jika hasilnya true.

Contoh nilai yang ditolak: nama institusi berisi spasi saja ("   "), tahun masuk 20a5, atau tahun lulus 2020 dengan tahun masuk 2025. Memilih jenis input atau papan ketik saja belum cukup karena keyboardType: TextInputType.number hanya mengubah tampilan papan ketik. Nilai tetap bisa dimasukkan lewat paste atau papan ketik fisik, dan papan ketik tidak bisa memeriksa aturan seperti rentang tahun, panjang karakter, input kosong, atau urutan tahun masuk dan lulus. Karena itu validasi di validator tetap diperlukan.

### AI DISCLOSURE
Saya menggunakan Claude model Sonnet 5.5 untuk membantu saya dalam fix error kode dan mengerjakan pertanyaan reflektif.
https://claude.ai/share/1dac2147-f8fc-4d32-a155-20bcc9ea618a