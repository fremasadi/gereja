import 'package:flutter/material.dart';
import 'package:gereja/app/modules/add_marriage/views/detail_marriage_view.dart';
import 'package:get/get.dart';
import '../../../data/services/date_service.dart';
import '../../../routes/app_pages.dart';
import '../controllers/marriage_controller.dart';

class MarriageView extends GetView<MarriageController> {
  const MarriageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MarriageView'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.ADD_MARRIAGE),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.marriages.isEmpty) {
          return const Center(child: Text('Data pernikahan kosong'));
        }
        return ListView.builder(
          itemCount: controller.marriages.length,
          itemBuilder: (context, index) {
            final marriage = controller.marriages[index];
            return ListTile(
              title: Text(marriage['nama_lengkap_pria'] ?? 'Nama Pria'),
              subtitle:
                  Text(formatDateWithDay(marriage['tanggal_pernikahan']) ?? ''),
              onTap: () async {
                final detail =
                    await controller.getMarriageDetail(marriage['id']);
                if (detail != null) {
                  Get.to(MarriageDetailView(), arguments: detail);
                } else {
                  Get.snackbar('Error', 'Gagal memuat detail');
                }
              },
            );
          },
        );
      }),
    );
  }
}
