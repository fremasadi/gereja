import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_infaq_controller.dart';

class AddInfaqView extends GetView<AddInfaqController> {
  const AddInfaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donasi Baru'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  validator: (value) =>
                      value!.isEmpty ? 'Nama wajib diisi' : null,
                ),
                TextFormField(
                  controller: controller.emailController,
                  decoration:
                      const InputDecoration(labelText: 'Email (opsional)'),
                ),
                TextFormField(
                  controller: controller.phoneController,
                  decoration:
                      const InputDecoration(labelText: 'No HP (opsional)'),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: controller.amountController,
                  decoration:
                      const InputDecoration(labelText: 'Jumlah Donasi (Rp)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Jumlah donasi wajib diisi' : null,
                ),
                const SizedBox(height: 10),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedType.value,
                      onChanged: (val) => controller.selectedType.value = val!,
                      items: controller.types
                          .map((type) => DropdownMenuItem(
                              value: type, child: Text(type.capitalize!)))
                          .toList(),
                      decoration:
                          const InputDecoration(labelText: 'Jenis Donasi'),
                    )),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.messageController,
                  decoration:
                      const InputDecoration(labelText: 'Pesan (opsional)'),
                  maxLines: 3,
                ),
                Obx(() => CheckboxListTile(
                      value: controller.isAnonymous.value,
                      onChanged: (val) =>
                          controller.isAnonymous.value = val ?? false,
                      title: const Text('Sembunyikan nama (donasi anonim)?'),
                    )),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  onPressed: controller.submitDonation,
                  label: const Text('Kirim Donasi'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
