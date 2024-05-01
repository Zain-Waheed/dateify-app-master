

import 'package:dateify_project/src/auth/view/signin/signin.dart';
import 'package:dateify_project/src/auth/view/widgets/app_button.dart';
import 'package:dateify_project/src/auth/view/widgets/auth_widget.dart';
import 'package:dateify_project/src/base_screen/home/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';

class RulesView extends StatefulWidget {
  static String route = '/rulesView';
  const RulesView({Key? key}) : super(key: key);

  @override
  State<RulesView> createState() => _RulesViewState();
}

class _RulesViewState extends State<RulesView> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(bottom: 20,left: 30),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AppButton(
          buttonText: 'got_it',
          onpressed: (){
            Get.offAllNamed(SignInView.route);
          },
          width: queryData.size.width*0.85,
          isWhite:false,
        ),),
      ),
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
                  padding: const EdgeInsets.symmetric(horizontal:24)+EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1-Follow These Guidelines When Posting About Guys",
                            style: AppTextStyle.ModernEra(
                              AppColors.blackColor,
                              16.sp,
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.01,
                          ),
                          Text(
                            "Don't include even a single remotely negative word or accusation in the post text or post images. Even out of context, as a question, or implied. This includes name calling, assumptions, suspicions, possible defamation, or even words like crazy, ghosted, or weird. Have minimal to no detail in the post itself. 10 words max. Be vague like “Any tea?” or “ see comments” then put all of the details in the comments. Don’t include any personal or contact information, as listed in Rule #3.",
                            style: AppTextStyle.ModernEra(
                              AppColors.darkGreyColor,
                              12.sp,
                              FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.01,
                          ),
                          Text(
                            "1-Follow These Guidelines When Posting About Guys",
                            style: AppTextStyle.ModernEra(
                              AppColors.blackColor,
                              16.sp,
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.01,
                          ),
                          Text(
                            "Don't include even a single remotely negative word or accusation in the post text or post images. Even out of context, as a question, or implied. This includes name calling, assumptions, suspicions, possible defamation, or even words like crazy, ghosted, or weird. Have minimal to no detail in the post itself. 10 words max. Be vague like “Any tea?” or “ see comments” then put all of the details in the comments. Don’t include any personal or contact information, as listed in Rule #3.",
                            style: AppTextStyle.ModernEra(
                              AppColors.darkGreyColor,
                              12.sp,
                              FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.01,
                          ),
                          Text(
                            "1-Follow These Guidelines When Posting About Guys",
                            style: AppTextStyle.ModernEra(
                              AppColors.blackColor,
                              16.sp,
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.01,
                          ),
                          Text(
                            "Don't include even a single remotely negative word or accusation in the post text or post images. Even out of context, as a question, or implied. This includes name calling, assumptions, suspicions, possible defamation, or even words like crazy, ghosted, or weird. Have minimal to no detail in the post itself. 10 words max. Be vague like “Any tea?” or “ see comments” then put all of the details in the comments. Don’t include any personal or contact information, as listed in Rule #3.",
                            style: AppTextStyle.ModernEra(
                              AppColors.darkGreyColor,
                              12.sp,
                              FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
}}
