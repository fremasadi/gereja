import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/repository/marriage_repository.dart';

class AddMarriageController extends GetxController {
  final namaPria = TextEditingController();
  final namaWanita = TextEditingController();
  final noTelepon = TextEditingController();
  final tanggalPernikahan = TextEditingController();

  // JSON fields
  final fotocopyKTP = <String>[].obs;
  final fotocopyKK = <String>[].obs;
  final fotocopyAkteKelahiran = <String>[].obs;
  final fotocopyAkteBaptisSelam = <String>[].obs;
  final akteNikahOrangTua = <String>[].obs;
  final fotocopyN1N4 = <String>[].obs;
  final fotoBerdua = <String>[].obs;

  final isLoading = false.obs;

  final MarriageRepository repo = MarriageRepository();

  Future<void> submitMarriage() async {
    isLoading.value = true;

    final data = {
      'nama_lengkap_pria': namaPria.text,
      'nama_lengkap_wanita': namaWanita.text,
      'no_telepon': noTelepon.text,
      'tanggal_pernikahan': tanggalPernikahan.text,
      'fotocopy_ktp': fotocopyKTP.toList(),
      'fotocopy_kk': fotocopyKK.toList(),
      'fotocopy_akte_kelahiran': fotocopyAkteKelahiran.toList(),
      'fotocopy_akte_baptis_selam': fotocopyAkteBaptisSelam.toList(),
      'akte_nikah_orang_tua': akteNikahOrangTua.toList(),
      'fotocopy_n1_n4': fotocopyN1N4.toList(),
      'foto_berdua': fotoBerdua.toList(),
    };

    final success = await repo.createMarriage(data);

    isLoading.value = false;

    if (success) {
      Get.snackbar('Sukses', 'Data pernikahan berhasil ditambahkan');

      // 🧹 Clear semua input
      namaPria.clear();
      namaWanita.clear();
      noTelepon.clear();
      tanggalPernikahan.clear();

      fotocopyKTP.clear();
      fotocopyKK.clear();
      fotocopyAkteKelahiran.clear();
      fotocopyAkteBaptisSelam.clear();
      akteNikahOrangTua.clear();
      fotocopyN1N4.clear();
      fotoBerdua.clear();

      Get.back();
    } else {
      Get.snackbar('Gagal', 'Terjadi kesalahan saat menyimpan');
    }
  }

  Future<void> pickImages(RxList<String> targetList) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    for (var image in images) {
      targetList
          .add(image.path); // atau upload dan ambil URL jika pakai API upload
    }
  }

  @override
  void onClose() {
    namaPria.dispose();
    namaWanita.dispose();
    noTelepon.dispose();
    tanggalPernikahan.dispose();
    super.onClose();
  }
}
