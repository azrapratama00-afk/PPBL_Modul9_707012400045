import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/produk_favorit.dart';
import '../helpers/pengaturan_helper.dart';

class HalamanNama extends StatefulWidget {
  const HalamanNama({super.key});

  @override
  State<HalamanNama> createState() => _HalamanNamaState();
}

class _HalamanNamaState extends State<HalamanNama> {
  late final Box<ProdukFavorit> boxFavorit;

  @override
  void initState() {
    super.initState();
    bukaBoxFavorit();
  }

  Future<void> bukaBoxFavorit() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProdukFavoritAdapter());
    boxFavorit = await Hive.openBox<ProdukFavorit>('favoritBox');
  }

  Future<void> ambilData() async {
    await bukaBoxFavorit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Nama')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nama'),
              onChanged: (value) => PengaturanHelper.simpanNama(value),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
