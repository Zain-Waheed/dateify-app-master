

import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/resources/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/text_styles.dart';

class GroupSelectionBottomSheet extends StatefulWidget {
  const GroupSelectionBottomSheet({Key? key}) : super(key: key);

  @override
  State<GroupSelectionBottomSheet> createState() => _GroupSelectionBottomSheetState();
}

class _GroupSelectionBottomSheetState extends State<GroupSelectionBottomSheet> {
  List<String> options = ['Santa Clarita, CA', 'Los Angeles, CA', 'Long Beach, CA'];
  String? selectedOption;
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
                  onPressed: (){},
                  icon: Image.asset(AppImages.cross,color: AppColors.blackColor,))
            ],
          ),
          SizedBox(
            width: queryData.size.width*0.8,
            child: Text(getTranslated(context, 'which_group_you_want_to_publish_this_post')??""
              ,style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              18.sp,
              FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: queryData.size.height*0.02,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return RadioListTile(
                controlAffinity:ListTileControlAffinity.trailing,
                dense: false,
                contentPadding: EdgeInsets.zero,
                title: Text(option,style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    14.sp,
                    FontWeight.w600,
                ),),
                value: option,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value!;
                  });
                },
                activeColor: AppColors.mainPurpleColor, // Set the color of the selected dot
              );
            }).toList(),
          ),
          SizedBox(
            height: queryData.size.height*0.02,
          ),
        ],
      ),
    );
  }
}
