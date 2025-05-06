import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja/app/data/constants/const_color.dart';
import 'package:gereja/app/modules/home/views/counseling_view.dart';
import 'package:gereja/app/modules/home/views/schedule_view.dart';
import 'package:gereja/app/modules/home/views/seatbooking_view.dart';
import 'package:gereja/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadUserName();
    });
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: ScreenUtil().screenHeight * .5,
                width: ScreenUtil().screenWidth,
              ),
              Container(
                height: ScreenUtil().screenHeight * .4,
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(100.sp),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().statusBarHeight,
                    left: 16.sp,
                    right: 16.sp),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              'Hi ${controller.userName.value.isNotEmpty ? controller.userName.value : 'Guest'}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: ConstColor.white,
                                fontFamily: 'Medium',
                              ),
                            )),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ConstColor.white,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.logout,
                      size: 28.sp,
                      color: ConstColor.white,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().screenHeight * .2 - 50,
                  left: 16.sp,
                  right: 16.sp,
                ),
                padding: EdgeInsets.all(8.sp),
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white, // Ganti sesuai ConstColor.white jika ada
                  borderRadius: BorderRadius.circular(16.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.sp,
                  mainAxisSpacing: 16.sp,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _MenuItem(
                      icon: Icons.calendar_today,
                      label: "Schedule",
                      onPress: () {
                        Get.to(ScheduleView());
                      },
                    ),
                    _MenuItem(
                      icon: Icons.headset_mic,
                      label: "Counseling",
                      onPress: () {
                        Get.to(CounselingView());
                      },
                    ),
                    _MenuItem(
                      icon: Icons.event_seat,
                      label: "Seat Booking",
                      onPress: () {
                        Get.to(SeatbookingView());
                      },
                    ),
                    _MenuItem(
                      icon: Icons.favorite,
                      label: "Marriage",
                      onPress: () {},
                    ),
                    _MenuItem(
                      icon: Icons.menu_book,
                      label: "Bible Study",
                      onPress: () {
                        Get.toNamed(Routes.BIBLE);
                      },
                    ),
                    _MenuItem(
                      icon: Icons.account_balance_outlined,
                      label: "About",
                      onPress: () {},
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPress;

  const _MenuItem(
      {required this.icon, required this.label, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue, size: 32.sp),
          SizedBox(height: 8.sp),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
