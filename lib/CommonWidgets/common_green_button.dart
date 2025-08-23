import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';

class CommonGreenButton extends StatelessWidget {
  final String btnTitle;
  final Color color;
  VoidCallback onCustomButtonPressed;

  CommonGreenButton(this.btnTitle, this.onCustomButtonPressed, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 14, right: 14),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onCustomButtonPressed,
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: color),
              backgroundColor: color,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8.5.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                // side: BorderSide(color: skygreen_24d39e, width: 0),
              ),
            ),
            child: Text(
              btnTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: (color??"") == sign_up_bg_color?login_bg_color:Colors.white,
                  fontSize: 15,
                   fontFamily: fontInterSemiBold),
            )),
      ),
    );
  }
}
