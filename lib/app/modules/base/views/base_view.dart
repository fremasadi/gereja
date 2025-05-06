import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja/app/data/constants/const_color.dart';
import 'package:gereja/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';

import '../../community/views/community_view.dart';
import '../../giving/views/giving_view.dart';
import '../../home/views/home_view.dart';
import '../../scan/views/scan_view.dart';
import '../controllers/base_controller.dart';

class BaseView extends StatelessWidget {
  BaseView({super.key});

  final BaseController controller = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
        builder: (controller) {
          return Scaffold(
            body: IndexedStack(
              index: controller.currentIndex,
              children: const [
                HomeView(),
                CommunityView(),
                ScanView(),
                GivingView(),
                ProfileView(),
              ],
            ),
            bottomNavigationBar: Container(
              height: 65.h,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home, "Home", controller),
                  _buildNavItem(1, Icons.group, "Community", controller),
                  _buildScanButton(controller),
                  _buildNavItem(3, Icons.card_giftcard, "Giving", controller),
                  _buildNavItem(4, Icons.person, "Profile", controller),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildNavItem(int index, IconData icon, String title, BaseController controller) {
    final bool isSelected = controller.currentIndex == index;
    return InkWell(
      onTap: () => controller.changeIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: isSelected ? ConstColor.primaryColor : Colors.grey,
          ),
           SizedBox(height: 6.h), // Jarak sangat minimal antara ikon dan teks
          Text(
            title,
            style: TextStyle(
                fontSize: 10.sp,
              color: isSelected ? ConstColor.primaryColor : Colors.grey,
              height: 0.8, // Mengurangi line height
            ),
          )
        ],
      ),
    );
  }

  Widget _buildScanButton(BaseController controller) {
    return Transform.translate(
      offset: const Offset(0, -15), // Geser 15 pixel ke atas
      child: InkWell(
        onTap: () => controller.changeIndex(2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ConstColor.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child:  Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
             SizedBox(height: 6.h),
            Text(
              "Scan",
              style: TextStyle(
                fontSize: 10.sp,
                color: controller.currentIndex == 2 ? ConstColor.primaryColor : Colors.grey,
                height: 0.8,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}