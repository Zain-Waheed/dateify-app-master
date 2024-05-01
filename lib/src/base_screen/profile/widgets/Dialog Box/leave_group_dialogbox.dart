
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/text_styles.dart';



class LeaveGroupDialogBox extends StatefulWidget {
  const LeaveGroupDialogBox({Key? key}) : super(key: key);

  @override
  State<LeaveGroupDialogBox> createState() => _LeaveGroupDialogBoxState();
}

class _LeaveGroupDialogBoxState extends State<LeaveGroupDialogBox> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColors.blackColor.withOpacity(0.4),
      body: Center(
        child: Container(
          width: queryData.size.width,
          height: queryData.size.height*0.2,
          margin: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: AppColors.dialogColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: queryData.size.height*0.02,
              ),
              Text("Leave group",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  14.sp,
                  FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: queryData.size.height*0.01,
              ),
              Text("Santa Clarita, CA ?",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  14.sp,
                  FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: queryData.size.height*0.01,
              ),
              Text("Are you sure you want to leave group Santa Clarita, CA? ",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  14.sp,
                  FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

