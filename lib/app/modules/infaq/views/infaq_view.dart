import 'package:flutter/material.dart';
import 'package:gereja/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/infaq_controller.dart';

class InfaqView extends GetView<InfaqController> {
  const InfaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infaq'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.toNamed(Routes.ADD_INFAQ);
      }),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          print(controller.errorMessage.value);
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.infaqList.isEmpty) {
          return const Center(child: Text('Belum ada data infaq.'));
        }

        return ListView.builder(
          itemCount: controller.infaqList.length,
          itemBuilder: (context, index) {
            final infaq = controller.infaqList[index];
            return ListTile(
              title: Text(infaq.displayName ?? '-'),
              subtitle: Text('Rp ${infaq.amount?.toStringAsFixed(0) ?? '0'}'),
              trailing: Text(infaq.status ?? 'pending'),
            );
          },
        );
      }),
    );
  }
}
