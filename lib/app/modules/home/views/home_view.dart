import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja/app/data/constants/const_color.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
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
                        Text(
                          'Hi samuel',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ConstColor.white,
                            fontFamily: 'Medium',
                          ),
                        ),
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
                      Icons.settings,
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
                height: 250,
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: ConstColor.white,
                  borderRadius: BorderRadius.circular(16.sp),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
