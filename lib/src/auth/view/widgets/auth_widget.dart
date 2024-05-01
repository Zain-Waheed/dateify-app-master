

import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/resources/app_colors.dart';
import 'package:dateify_project/resources/app_images.dart';
import 'package:dateify_project/resources/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthWidget extends StatefulWidget {
  final Widget funBody;
  const AuthWidget({Key? key, required this.funBody}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        color: AppColors.greyColor,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: queryData.size.height*0.03,
                ),
                Image.asset(AppImages.logoPurple,
                  height:queryData.size.height*0.06,
                  width: queryData.size.width*0.2,),
                Text(getTranslated(context,'dateify')??"",
                  style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    20.sp,
                    FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height*0.03,
                ),
                Container(
                  height:queryData.size.height*0.8,
                  width: queryData.size.width,
                  padding: const EdgeInsets.symmetric(horizontal:24),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: widget.funBody,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
