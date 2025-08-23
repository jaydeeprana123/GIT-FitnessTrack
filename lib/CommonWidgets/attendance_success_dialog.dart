import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import 'package:get/get.dart';

class AttendanceSuccessDialog extends StatelessWidget {
  final VoidCallback onClose;

  const AttendanceSuccessDialog({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the dialog from being dismissed when the back button is pressed
        return false; // return false to prevent popping
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: 380.h, // Use ScreenUtil for responsive height
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              SizedBox(height: 16.h),
              Text(
                "Attendance Submitted",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                "Your attendance has been submitted successfully.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {
                  onClose();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                ),
                child: Text(
                  "Ok",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
