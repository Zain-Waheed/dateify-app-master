
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_images.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../auth/view/widgets/app_button.dart';

class SearchGroupJoinBottom extends StatefulWidget {
  final String groupName;
  const SearchGroupJoinBottom({Key? key, required this.groupName}) : super(key: key);

  @override
  State<SearchGroupJoinBottom> createState() => _SearchGroupJoinBottomState();
}

class _SearchGroupJoinBottomState extends State<SearchGroupJoinBottom> {
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
                   Get.back();
                   FocusScope.of(context).unfocus();
                  },
                  icon: Image.asset(AppImages.cross,color: AppColors.blackColor,))
            ],
          ),
          Text("Your application to ${widget.groupName}, CA has been submitted for review"
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
          Text(getTranslated(context, 'we_will_notify_you')??""
            ,style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              14.sp,
              FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: queryData.size.height*0.06,
          ),
          AppButton
            (
              buttonText: "got_it",
              onpressed: (){
                // widget.onPressed();
                Get.back();
                // Navigator.of(context).pop();
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
