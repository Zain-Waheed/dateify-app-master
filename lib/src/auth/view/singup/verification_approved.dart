
import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/src/auth/view/singup/rules.dart';
import 'package:dateify_project/src/auth/view/widgets/auth_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import '../widgets/app_button.dart';

class VerificationApprovedView extends StatefulWidget {
  static String route = '/verificationApprovedView';
  const VerificationApprovedView({Key? key}) : super(key: key);

  @override
  State<VerificationApprovedView> createState() => _VerificationApprovedViewState();
}

class _VerificationApprovedViewState extends State<VerificationApprovedView> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return AuthWidget(
        funBody:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: queryData.size.height*0.03,
            ),
            Text(getTranslated(context,'your_verification_has_been_approved!')??"",
              style: AppTextStyle.ModernEra(
                AppColors.blackColor,
                20.sp,
                FontWeight.w700,
              ),
            ),
            Text(getTranslated(context,'welcome_to_dateify_please_read')??"",
              style: AppTextStyle.ModernEra(
                AppColors.darkGreyColor,
                12.sp,
                FontWeight.w400,
              ),
            ),
            Spacer(),
            //=============
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  GestureDetector(
                    onTap: (){},
                    child: Image.asset(AppImages.infocircle,
                      height:queryData.size.height*0.05,
                      width: queryData.size.width*0.06,),
                  ),
                  SizedBox(
                    width: queryData.size.height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: queryData.size.height*0.08,
                    width: queryData.size.width*0.76,
                    child: Text(
                      getTranslated(context, 'we_strongly_encourage') ?? "",
                      style: AppTextStyle.ModernEra(
                        AppColors.darkGreyColor,
                        12.sp,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ]
            ),
            SizedBox(
              height: queryData.size.height * 0.02,
            ),
            AppButton(
              buttonText: 'house_rules',
              onpressed: (){
                Get.offAllNamed(RulesView.route);
              },
              width: queryData.size.width,
              isWhite: false,
            ),
            SizedBox(
              height: queryData.size.height * 0.04,
            ),
          ],
        ),
    );
  }
}
