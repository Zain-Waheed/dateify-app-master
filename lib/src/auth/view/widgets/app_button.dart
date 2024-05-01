
import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/resources/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/app_colors.dart';

class AppButton extends StatelessWidget {
  final double width;
  final String buttonText;
  final Function onpressed;
  final bool isWhite;
  AppButton({
    required this.buttonText,
    required this.onpressed, required this.width, required this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        color: isWhite==true?AppColors.darkGreyColor:AppColors.mainPurpleColor,
        boxShadow: [
          BoxShadow(
              color: AppColors.blackColor.withOpacity(0.3), offset: Offset(0, 2), blurRadius: 5.0)
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(width, 50)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: isWhite==true?null:(){
          onpressed();
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: queryData.size.width*0.04,
            bottom:queryData.size.width*0.04,
          ),
          child: Text(
            getTranslated(context, buttonText)??"",
            style: AppTextStyle.ModernEra(AppColors.whiteColor, 14.sp, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}