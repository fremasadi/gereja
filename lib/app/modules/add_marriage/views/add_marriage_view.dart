import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_marriage_controller.dart';

class AddMarriageView extends GetView<AddMarriageController> {
  const AddMarriageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Pernikahan'),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    TextField(
                      controller: controller.namaPria,
                      decoration:
                          const InputDecoration(labelText: 'Nama Lengkap Pria'),
                    ),
                    TextField(
                      controller: controller.namaWanita,
                      decoration: const InputDecoration(
                          labelText: 'Nama Lengkap Wanita'),
                    ),
                    TextField(
                      controller: controller.noTelepon,
                      decoration:
                          const InputDecoration(labelText: 'No Telepon'),
                      keyboardType: TextInputType.phone,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          controller.tanggalPernikahan.text =
                              pickedDate.toIso8601String().split('T')[0];
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          controller: controller.tanggalPernikahan,
                          decoration: const InputDecoration(
                            labelText: 'Tanggal Pernikahan',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                    buildFileInput("Fotocopy KTP", controller.fotocopyKTP,
                        () => controller.pickImages(controller.fotocopyKTP)),
                    buildFileInput("Fotocopy KK", controller.fotocopyKK,
                        () => controller.pickImages(controller.fotocopyKK)),
                    buildFileInput(
                        "Akte Kelahiran",
                        controller.fotocopyAkteKelahiran,
                        () => controller
                            .pickImages(controller.fotocopyAkteKelahiran)),
                    buildFileInput(
                        "Akte Baptis",
                        controller.fotocopyAkteBaptisSelam,
                        () => controller
                            .pickImages(controller.fotocopyAkteBaptisSelam)),
                    buildFileInput(
                        "Akte Nikah Orang Tua",
                        controller.akteNikahOrangTua,
                        () => controller
                            .pickImages(controller.akteNikahOrangTua)),
                    buildFileInput("Fotocopy N1-N4", controller.fotocopyN1N4,
                        () => controller.pickImages(controller.fotocopyN1N4)),
                    buildFileInput("Foto Berdua", controller.fotoBerdua,
                        () => controller.pickImages(controller.fotoBerdua)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.submitMarriage,
                      child: const Text('Simpan'),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  Widget buildFileInput(
      String label, RxList<String> targetList, VoidCallback onPick) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
        ElevatedButton.icon(
          onPressed: onPick,
          icon: const Icon(Icons.image),
          label: Text('Pilih Gambar $label'),
        ),
        Obx(() => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: targetList.map((path) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(
                      File(path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () => targetList.remove(path),
                    )
                  ],
                );
              }).toList(),
            )),
        const SizedBox(height: 10),
      ],
    );
  }
}
