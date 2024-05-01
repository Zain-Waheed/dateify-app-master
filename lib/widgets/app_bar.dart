import 'package:dateify_project/widgets/top_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../localization/app_localization.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/text_styles.dart';

class AppBarWidget extends StatefulWidget {
  final VoidCallback backFn;
  AppBarWidget({Key? key, required this.backFn}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          leading: SizedBox(),
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          title:Padding(
            padding: EdgeInsets.only(top: Get.height*0.045),
            child: Text(getTranslated(context,"kstyles_kids")??"",),
          ),
          // titleTextStyle: AppTextStyle.Jalnan(
          //   AppColors.appNameColor,
          //   18.sp,
          //   FontWeight.w800,
          // ),
        ),
        TopBar(),
        Container(
          height: Get.height*0.1,
          padding: EdgeInsets.all(9),
          margin: EdgeInsets.only(top: Get.height*0.06,left: Get.width*0.01),
          child: IconButton(
            onPressed: widget.backFn,
            icon: Image.asset(AppImages.backIcon,),
          ),
        ),
      ],
    );
  }
}

