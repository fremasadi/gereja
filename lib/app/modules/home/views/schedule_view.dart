import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja/app/data/constants/cons_url.dart';
import 'package:gereja/app/data/constants/const_color.dart';
import 'package:gereja/app/modules/home/controllers/schedule_controller.dart';
import 'package:get/get.dart';

import '../../../data/services/date_service.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule',
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.schedules.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.schedules.length,
          itemBuilder: (context, index) {
            final item = controller.schedules[index];
            return Container(
              padding: EdgeInsets.all(8.sp),
              margin: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      '$imgUrl${item['images']}',
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['location_name'] ?? '',
                          style: TextStyle(
                              fontSize: 14.sp, fontFamily: 'SemiBold'),
                        ),
                        Text(
                          item['date'] != null
                              ? formatDateWithDay(item['date'])
                              : formatRecurringDaysSmart(
                                  item['recurring_days']),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: 'SemiBold',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => ScheduleDetail(schedule: item));
                    },
                    icon: Icon(Icons.arrow_forward_ios, size: 28.sp),
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

class ScheduleDetail extends StatelessWidget {
  final Map<String, dynamic> schedule;

  const ScheduleDetail({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColor.primaryColor,
        title: const Text('Detail Schedule'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (schedule['images'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  '$imgUrl${schedule['images']}',
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16.h),
            Text(
              schedule['location_name'] ?? '',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'SemiBold',
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              schedule['date'] != null
                  ? formatDateWithDay(schedule['date'])
                  : formatRecurringDaysSmart(schedule['recurring_days']),
              style: TextStyle(
                fontSize: 10.sp,
                fontFamily: 'SemiBold',
                color: Colors.grey,
              ),
            ),
            Text(
              'Bertempat Di ${schedule['location_spesific']}',
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
            Text(
              schedule['location_address'] ?? '',
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
            Text(
              'Jam:${schedule['time']}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            Divider(),
            Text(
              'Tema: ${schedule['theme'] ?? '-'}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Ayat: ${schedule['bible_verse'] ?? '-'}',
              style: TextStyle(
                fontSize: 13.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Judul Khotbah:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              schedule['sermon_title'] ?? '-',
              style: TextStyle(fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              'Isi Khotbah:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              schedule['sermon_content']?.replaceAll(r'\n', '\n') ?? '-',
              style: TextStyle(fontSize: 13.sp, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
