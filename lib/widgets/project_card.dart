// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // TUGAS 7 (GANTI JADI MENYESUAIKAN COLOR DARI CLASS ITEMHOMEPAGE)
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () async {
          final messenger = ScaffoldMessenger.of(context);

          if (item.name == "Lihat Proyek") {
            // Daftar proyek bersifat publik, tidak perlu login.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectListScreen(),
              ),
            );
          } else if (item.name == "Tambah Proyek") {
            // Lindungi aksi: minta login dulu kalau belum terautentikasi.
            if (!await ensureLoggedIn(context)) return;
            if (!context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectFormPage()),
            );
          } else if (item.name == "Tambah Pendidikan") {
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Kamu telah menekan tombol ${item.name}!"),
                ),
              );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducationFormPage(),
              ),
            );
          } else if (item.name == "Logout") {
            final auth = context.read<AuthState>();
            if (auth.isLoggedIn) {
              await auth.logout();
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text("Berhasil logout.")),
                );
            } else {
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text("Kamu belum login.")),
                );
            }
          } else {
            // Menampilkan SnackBar dengan pesan interaktif.
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Kamu telah menekan tombol ${item.name}!"),
                ),
              );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
