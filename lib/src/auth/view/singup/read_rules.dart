

import 'package:dateify_project/src/auth/view/singup/phone_view.dart';
import 'package:dateify_project/src/auth/view/singup/rules.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';

class ReadRules extends StatefulWidget {
  static String route = '/readRules';
  const ReadRules({Key? key}) : super(key: key);

  @override
  State<ReadRules> createState() => _ReadRulesState();
}

class _ReadRulesState extends State<ReadRules> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(AppImages.logoIcon,
              height:MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.5,),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
            ),
            Container(
              height:MediaQuery.of(context).size.height*0.35,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal:20),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  Text(getTranslated(context,'dateify_house_rules')??"",
                    style: AppTextStyle.ModernEra(
                      AppColors.blackColor,
                      22.sp,
                      FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Text(getTranslated(context,'we_strongly_recommend')??"",
                    style: AppTextStyle.ModernEra(
                      AppColors.blackColor,
                      12.sp,
                      FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height*0.02,
                        horizontal: MediaQuery.of(context).size.width*0.3,
                      ),
                      primary: AppColors.mainPurpleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius
                            .circular(27.0),
                      ),
                    ),
                    onPressed: () {
                      Get.offAllNamed(RulesView.route);
                    },
                    child: Text(getTranslated(context,'read_rules')??"",
                      style: AppTextStyle.ModernEra(
                        AppColors.whiteColor,
                        14.sp,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
