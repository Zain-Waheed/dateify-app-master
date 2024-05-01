
import 'package:dateify_project/resources/app_colors.dart';
import 'package:dateify_project/resources/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../localization/app_localization.dart';
import '../../../resources/text_styles.dart';
import '../../auth/view/signin/signin.dart';
import '../../auth/view/singup/phone_view.dart';

class OnBoardingView extends StatefulWidget {
  static String route = '/onBoardingView';
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
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
              height:MediaQuery.of(context).size.height*0.15,
              width: MediaQuery.of(context).size.width*0.4,),
            Text(getTranslated(context,'dateify')??"",
              style: AppTextStyle.ModernEra(
                AppColors.whiteColor,
                34.sp,
                FontWeight.w700,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.1,
            ),
            Container(
              height:MediaQuery.of(context).size.height*0.5,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal:12),
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
                    height: MediaQuery.of(context).size.height*0.05,
                  ),
                  Text(getTranslated(context,'welcome_to_dateify')??"",
                    style: AppTextStyle.ModernEra(
                      AppColors.blackColor,
                      35.sp,
                      FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Text(getTranslated(context,'an_app_to_help_you_stay_saf')??"",
                    style: AppTextStyle.ModernEra(
                      AppColors.blackColor,
                      10.sp,
                      FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.08,
                  ),
                  TextButton(
                    onPressed: (){
                      Get.offAllNamed(SignInView.route);
                    },
                    child: Text(getTranslated(context,'sign_in')??"",
                      style: AppTextStyle.ModernEra(
                        AppColors.mainPurpleColor,
                        15.sp,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                      Get.offAllNamed(PhoneView.route);
                    },
                    child: Text(getTranslated(context,'create_account')??"",
                      style: AppTextStyle.ModernEra(
                        AppColors.whiteColor,
                        14.sp,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
