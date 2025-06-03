import 'package:flutter/material.dart';
import 'package:gereja/app/data/services/date_service.dart';
import 'package:get/get.dart';

class MarriageDetailView extends StatelessWidget {
  const MarriageDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> detail = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pernikahan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Nama Pria: ${detail['nama_lengkap_pria']}'),
            Text('Nama Wanita: ${detail['nama_lengkap_wanita']}'),
            Text('No Telepon: ${detail['no_telepon']}'),
            Text(
                'Tanggal Pernikahan: ${formatDateWithDay(detail['tanggal_pernikahan'])}'),
            // Jika kamu ingin tampilkan gambar URL dari json image array
            // if (detail['fotocopy_ktp'] != null) Text('Fotocopy KTP:'),
            // if (detail['fotocopy_ktp'] != null)
            //   ...List<Widget>.from(
            //     (detail['fotocopy_ktp'] as List<dynamic>).map(
            //       (url) => Image.network(url, height: 100),
            //     ),
            //   ),
            // Tambahkan bagian lain sesuai kebutuhan...
          ],
        ),
      ),
    );
  }
}
