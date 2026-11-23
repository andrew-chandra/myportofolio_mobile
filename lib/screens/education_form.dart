import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = "";
  String _level = "S1"; 
  String _major = "";
  String _startYear = "";
  String _endYear = "";

  final List<String> _levels = ['SMA/SMK', 'D3', 'S1', 'S2', 'S3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
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
                // === Institution ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Universitas Indonesia",
                      labelText: "Nama Institusi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _institution = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Nama institusi tidak boleh kosong!";
                      }
                      if (value.trim().length < 3) {
                        return "Nama institusi minimal 3 karakter!";
                      }
                      if (value.trim().length > 100) {
                        return "Nama institusi maksimal 100 karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Level ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Jenjang",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    initialValue: _level,
                    items: _levels
                        .map(
                          (level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _level = newValue!;
                      });
                    },
                  ),
                ),

                // === Major ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Ilmu Komputer",
                      labelText: "Jurusan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _major = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Jurusan tidak boleh kosong!";
                      }
                      if (value.trim().length > 100) {
                        return "Jurusan maksimal 100 karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Start Year ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Contoh: 2025",
                      labelText: "Tahun Masuk",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _startYear = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Tahun masuk tidak boleh kosong!";
                      }
                      final year = int.tryParse(value.trim());
                      if (year == null) {
                        return "Tahun masuk harus berupa angka!";
                      }
                      if (year < 1950 || year > 2100) {
                        return "Tahun masuk harus antara 1950 dan 2100!";
                      }
                      return null;
                    },
                  ),
                ),

                // === End Year ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Contoh: 2029",
                      labelText: "Tahun Lulus",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _endYear = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Tahun lulus tidak boleh kosong!";
                      }
                      final end = int.tryParse(value.trim());
                      if (end == null) {
                        return "Tahun lulus harus berupa angka!";
                      }
                      if (end < 1950 || end > 2100) {
                        return "Tahun lulus harus antara 1950 dan 2100!";
                      }
                      final start = int.tryParse(_startYear.trim());
                      if (start != null && end < start) {
                        return "Tahun lulus tidak boleh sebelum tahun masuk!";
                      }
                      return null;
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Pendidikan berhasil ditambahkan!',
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Institusi: $_institution'),
                                      Text('Jenjang: $_level'),
                                      Text('Jurusan: $_major'),
                                      Text('Tahun Masuk: $_startYear'),
                                      Text('Tahun Lulus: $_endYear'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _formKey.currentState!.reset();
                                      // Dropdown kembali ke nilai awal saat reset.
                                      setState(() {
                                        _level = "S1";
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Save",
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
