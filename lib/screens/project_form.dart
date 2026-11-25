// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = '';
  String _description = '';
  String _category = 'Web Development';
  String _thumbnail = '';
  bool _isSubmitting = false;

  // Pastikan panjang setiap kategori <= 20 karakter sesuai CharField(max_length=20) di Django
  final List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Pastikan sudah login; kalau belum, arahkan ke LoginScreen.
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final auth = context.read<AuthState>();
    final api = context.read<ApiClient>();
    final messenger = ScaffoldMessenger.of(context);
    final token = auth.token;
    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      title: _projectName.trim(),
      description: _description.trim(),
      category: _category.trim(),
      thumbnail: _thumbnail.trim().isEmpty ? null : _thumbnail.trim(),
    );

    try {
      final created = await api.createProject(newProject, token: token);
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Proyek berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('ID: ${created.id ?? '-'}'),
                  Text('Nama Proyek: ${created.title}'),
                  Text('Deskripsi: ${created.description}'),
                  Text('Kategori: ${created.category}'),
                  if (created.thumbnail != null &&
                      created.thumbnail!.isNotEmpty)
                    Text('Thumbnail: ${created.thumbnail}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;
      // Halaman ini dibuka lewat pushReplacement dari drawer, jadi kembali
      // ke Home (bukan pop) agar tidak berakhir di layar kosong.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        // Token tidak valid/kedaluwarsa: logout lalu minta login ulang.
        await auth.logout();
        if (!mounted) return;
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Sesi berakhir. Silakan login kembali.'),
          ),
        );
        await ensureLoggedIn(context);
      } else {
        messenger.showSnackBar(
          SnackBar(content: Text('Gagal menyimpan proyek (${e.statusCode})')),
        );
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Project Name ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: !_isSubmitting,
                    decoration: InputDecoration(
                      hintText: 'Nama Proyek',
                      labelText: 'Nama Proyek',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      _projectName = value ?? '';
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama proyek tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),

                // === Description ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: !_isSubmitting,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Deskripsi Proyek',
                      labelText: 'Deskripsi Proyek',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      _description = value ?? '';
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Deskripsi proyek tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),

                // === Category ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Kategori Proyek',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    initialValue: _category,
                    items: _categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                    onChanged: _isSubmitting
                        ? null
                        : (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _category = newValue;
                              });
                            }
                          },
                  ),
                ),

                // === Thumbnail URL (Optional) ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: !_isSubmitting,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      hintText: 'https://example.com/gambar.png (opsional)',
                      labelText: 'URL Thumbnail Proyek (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      _thumbnail = value ?? '';
                    },
                    validator: (String? value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return null;
                      final uri = Uri.tryParse(text);
                      final valid =
                          uri != null &&
                          uri.host.isNotEmpty &&
                          (uri.scheme == 'http' || uri.scheme == 'https');
                      return valid
                          ? null
                          : 'Masukkan URL yang valid (http/https)';
                    },
                  ),
                ),

                // === Tombol Simpan ===
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.indigo),
                      ),
                      onPressed: _isSubmitting ? null : _submitForm,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
