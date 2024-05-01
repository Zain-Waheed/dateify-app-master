import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height*0.06,
      color:AppColors.themeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(top:4.h,right: 2.w),
            width: 2.w,
            height: 1.h,
          color: AppColors.brownColor,
      ),
          Container(
            margin: EdgeInsets.only(top:4.h,right: 1.w),
            decoration: BoxDecoration(
              color: AppColors.brownColor,
              shape: BoxShape.circle,
            ),
            width: 2.w,
            height: 1.h,
          ),
          Container(
              margin: EdgeInsets.only(top:4.h,right: 6.w),
            child: Image.asset(AppImages.ploygon,width: Get.width*0.03,height: Get.width*0.02,),
          ),
        ],
      ),
    );
  }
}
