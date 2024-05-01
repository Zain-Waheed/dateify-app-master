

import 'package:dateify_project/src/auth/view/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_images.dart';
import '../../../../../resources/text_styles.dart';

class PostedBottomSheet extends StatefulWidget {
  const PostedBottomSheet({Key? key}) : super(key: key);

  @override
  State<PostedBottomSheet> createState() => _PostedBottomSheetState();
}

class _PostedBottomSheetState extends State<PostedBottomSheet> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      width: queryData.size.width,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset(AppImages.cross,color: AppColors.blackColor,))
            ],
          ),
          Text(getTranslated(context, 'your_post_has_been_submitted_for_review')??""
            ,style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              18.sp,
              FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: queryData.size.height*0.02,
          ),
          Text(getTranslated(context, 'we_will_notify_you_when_your_post')??""
            ,style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              14.sp,
              FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: queryData.size.height*0.04,
          ),
          AppButton(
              buttonText: 'got_it',
              onpressed: (){
                Navigator.of(context).pop();
              },
              width: queryData.size.width,
              isWhite: false
          ),
          SizedBox(
            height: queryData.size.height*0.04,
          ),
        ],
      ),
    );
  }
}

