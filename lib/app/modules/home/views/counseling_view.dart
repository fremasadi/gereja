import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja/app/modules/widgets/input_text_form_field.dart';
import 'package:gereja/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/constants/const_color.dart';
import '../../widgets/input_form_button.dart';
import '../controllers/counseling_controller.dart';

class CounselingView extends GetView<CounselingController> {
  const CounselingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counseling'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ConstColor.primaryColor,
                  ),
                ),
                SizedBox(height: 16.h),

                // Name Field with Validation
                InputTextFormField(
                  controller: controller.nameController,
                  hint: 'Full Name',
                  textInputAction: TextInputAction.next,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                // Phone Field with Validation
                InputTextFormField(
                  controller: controller.phoneController,
                  hint: 'Phone Number',
                  textInputAction: TextInputAction.next,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^[0-9]{10,13}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                // Age Field with Validation
                InputTextFormField(
                  controller: controller.ageController,
                  hint: 'Age',
                  textInputAction: TextInputAction.next,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    int? age = int.tryParse(value);
                    if (age == null || age <= 0 || age > 120) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // Improved Date Picker
                Obx(() => GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate.value,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 90)),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: ConstColor.primaryColor,
                                colorScheme: ColorScheme.light(
                                  primary: ConstColor.primaryColor,
                                ),
                                buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          controller.selectedDate.value = picked;
                          controller.dateError.value = '';
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: controller.dateError.value.isNotEmpty
                                ? Colors.red
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Appointment Date',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  DateFormat('EEEE, MMMM d, yyyy')
                                      .format(controller.selectedDate.value),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                ),
                                controller.dateError.value.isNotEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 5.h),
                                        child: Text(
                                          controller.dateError.value,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.calendar_month,
                                color: ConstColor.primaryColor,
                                size: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 12.h,
                ),
                // Improved Gender Selector
                Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: controller.genderError.value.isNotEmpty
                                ? Colors.red
                                : Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, top: 8.h),
                            child: Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: Text('Male'),
                                  value: 'male',
                                  groupValue: controller.gender.value,
                                  onChanged: (value) {
                                    controller.gender.value = value!;
                                    controller.genderError.value = '';
                                  },
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: Text('Female'),
                                  value: 'female',
                                  groupValue: controller.gender.value,
                                  onChanged: (value) {
                                    controller.gender.value = value!;
                                    controller.genderError.value = '';
                                  },
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                ),
                              ),
                            ],
                          ),
                          controller.genderError.value.isNotEmpty
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(left: 12.w, bottom: 6.h),
                                  child: Text(
                                    controller.genderError.value,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                )
                              : SizedBox(height: 0),
                        ],
                      ),
                    )),
                SizedBox(height: 12.h),

                Text(
                  'Counseling Details',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ConstColor.primaryColor,
                  ),
                ),
                SizedBox(height: 16.h),

                Obx(() => DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Counseling Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                      ),
                      value: controller.selectedType.value,
                      onChanged: (String? newValue) {
                        controller.selectedType.value = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select counseling type';
                        }
                        return null;
                      },
                      items: ['personal', 'baptis', 'relationship', 'family']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                SizedBox(height: 16.h),
// Counseling Topic
                InputTextFormField(
                  controller: controller.topicController,
                  hint: 'Counseling Topic',
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter counseling topic';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 12.h),
                // Submit Button
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.submitCounseling(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          backgroundColor: ConstColor.primaryColor,
                        ),
                        child: controller.isLoading.value
                            ? SizedBox(
                                height: 24.h,
                                width: 24.w,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'Submit Request',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CounselingSuccess extends StatelessWidget {
  const CounselingSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/CounselingConfirm.png',
              height: 300.h,
              width: 300.w,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Counselling Registered',
            style: TextStyle(
              fontSize: 22.sp,
              color: ConstColor.white,
              fontFamily: 'SemiBold',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            child: Text(
              'Thank you for registering. You will receive WhatsApp confirmation shortly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Medium',
                color: ConstColor.white,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().screenWidth * .1),
            child: Text(
              'See you on the registered counselling. God bless you !!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Medium',
                color: ConstColor.white,
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            child: InputFormButton(
              color: ConstColor.white,
              onClick: () {
                // Navigate directly without touching the controller
                Get.offAllNamed(Routes.BASE);
              },
              titleText: 'Back To Home',
              textStyle: TextStyle(
                fontFamily: 'SemiBold',
                color: ConstColor.primaryColor,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            child: InputFormButton(
              color: ConstColor.primaryColor,
              onClick: () {
                // Only try to use controller if we can find it
                final controller = Get.isRegistered<CounselingController>()
                    ? Get.find<CounselingController>()
                    : null;

                if (controller != null) {
                  controller.resetForm();
                }
                Get.back();
              },
              titleText: 'Book Again',
              borderColor: Colors.white,
              borderWidth: 2,
              textStyle: TextStyle(
                fontFamily: 'SemiBold',
                color: ConstColor.white,
                fontSize: 14.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
