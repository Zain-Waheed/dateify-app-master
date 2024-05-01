

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/text_styles.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return  Container(
      margin: EdgeInsets.all(20),
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
      ),
    );
  }
}

