

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import '../../../../widgets/appbutton_purple.dart';
import '../view/pages/new_post.dart';

class DontPostWidget extends StatefulWidget {
  const DontPostWidget({Key? key,}) : super(key: key);

  @override
  State<DontPostWidget> createState() => _DontPostWidgetState();
}

class _DontPostWidgetState extends State<DontPostWidget> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Column(
      children: [
        SizedBox(
          height: queryData.size.height * 0.15,
        ),
        Center(
          child: Container(
            height: queryData.size.height * 0.3,
            width: queryData.size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(
                  width: 1,
                  color: AppColors
                      .greyColor //                   <--- border width here
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor,
                  spreadRadius: -1,
                  blurRadius: 1,
                  offset: Offset(0, 6), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30),
                  width: queryData.size.width * 0.8,
                  child: Column(
                    children: [
                      Text(
                        getTranslated(
                            context, 'group_doesn_have_any_posts_yet') ??
                            "",
                        style: AppTextStyle.ModernEra(
                          AppColors.blackColor,
                          20.sp,
                          FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.01,
                      ),
                      Text(
                        getTranslated(context,
                            'be_the_first_one_to_share_your_experience') ??
                            "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                AppButtonBorder(onpressed:(){
                  Get.to(NewPost());
                }, buttonText: 'write_post', buttonImage: AppImages.pen,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
