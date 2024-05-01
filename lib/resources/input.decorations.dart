
import 'package:dateify_project/resources/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../localization/app_localization.dart';
import 'app_colors.dart';

class AppInputDecoration{
  static InputDecoration circularFieldDecoration(Widget? preIcon,String hintText,Widget? suffixIcon)
  {
    return InputDecoration(
      floatingLabelBehavior:FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 2.h),
      fillColor: AppColors.whiteColor,
      labelText: getTranslated(Get.context!, hintText),
      prefixIcon: preIcon,
      suffixIcon:suffixIcon !=null? Container(

          margin: EdgeInsets.only(right: 25),
          child: suffixIcon
      ):null,
      suffixIconConstraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
      ),
      labelStyle: AppTextStyle.ModernEra(AppColors.blackColor.withOpacity(0.5), Get.width*0.04, FontWeight.w800,),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      filled: true,
    );
  }
  //-----------------------------------------------------------
  static InputDecoration circularFieldDecStartHint(Widget? preIcon,String hintText,Widget? suffixIcon)
  {
    return InputDecoration(
      floatingLabelBehavior:FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w)+EdgeInsets.only(top: 4.h),
      fillColor: AppColors.whiteColor,
      hintText: getTranslated(Get.context!, hintText),
      prefixIcon: preIcon,
      suffixIcon:suffixIcon !=null? Container(

          margin: EdgeInsets.only(right: 25),
          child: suffixIcon
      ):null,
      suffixIconConstraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
      ),
      hintStyle: AppTextStyle.ModernEra(AppColors.blackColor.withOpacity(0.5), Get.width*0.04, FontWeight.w800,),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      filled: true,
    );
  }
  //-----------------------------------------------------------
  static InputDecoration circularFieldPostDecoration(Widget? preIcon,String hintText,Widget? suffixIcon)
  {
    return InputDecoration(
      alignLabelWithHint: true,
      floatingLabelBehavior:FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w)+EdgeInsets.only(bottom: 70),
      fillColor: AppColors.whiteColor,
      labelText: getTranslated(Get.context!, hintText),
      prefixIcon: preIcon,
      suffixIcon:suffixIcon !=null? Container(

          margin: EdgeInsets.only(right: 25),
          child: suffixIcon
      ):null,
      suffixIconConstraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
      ),
      labelStyle: AppTextStyle.ModernEra(AppColors.blackColor.withOpacity(0.5), Get.width*0.04, FontWeight.w800,),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      filled: true,
    );
  }
  //---------------------------------------------------------
  static InputDecoration circularFieldDecorationClickOnly(Widget? preIcon,String hintText,Widget? suffixIcon)
  {
    return InputDecoration(
      floatingLabelBehavior:FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 2.h),
      fillColor: AppColors.whiteColor,
      labelText: getTranslated(Get.context!, hintText),
      suffixIcon:suffixIcon !=null? Container(
          margin: EdgeInsets.only(right: Get.width*0.03),
          child: suffixIcon
      ):null,
      suffixIconConstraints: BoxConstraints(
        maxHeight: Get.width*0.08,
        maxWidth: Get.width*0.08,
      ),
      labelStyle: AppTextStyle.ModernEra(AppColors.blackColor.withOpacity(0.5), Get.width*0.04, FontWeight.w800,),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      filled: true,
    );
  }
  static InputDecoration searchFieldDecorationSmall(Widget? preIcon,String hintText,Widget? suffixIcon)
  {
    return InputDecoration(
      floatingLabelBehavior:FloatingLabelBehavior.never ,
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(20, 12, 20, 12),
      fillColor: AppColors.whiteColor,
      labelText: getTranslated(Get.context!, hintText),
      labelStyle: AppTextStyle.ModernEra(AppColors.darkGreyColor.withOpacity(0.5), Get.width*0.04, FontWeight.w800,),
      suffixIcon: suffixIcon,
      prefixIcon: preIcon,
      suffixIconConstraints: BoxConstraints(
        maxHeight: Get.width*0.12,
        maxWidth: Get.width*0.12,
      ),
      hintStyle: AppTextStyle.ModernEra(AppColors.blackColor, Get.width*0.04, FontWeight.w800,),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      filled: true,
    );
  }



  static InputDecoration circularFieldDecSum(Widget? preIcon,String hintText,Widget? suffixIcon)
  {
    return InputDecoration(
      floatingLabelBehavior:FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 0.5.h),
      fillColor: AppColors.whiteColor,
      labelText: getTranslated(Get.context!, hintText),
      prefixIcon: preIcon,
      suffixIcon:suffixIcon !=null? Container(

          margin: EdgeInsets.only(right: 25),
          child: suffixIcon
      ):null,
      suffixIconConstraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
      ),
      labelStyle: AppTextStyle.ModernEra(AppColors.blackColor.withOpacity(0.5), Get.width*0.04, FontWeight.w800,),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
        borderSide: BorderSide(color: AppColors.mainPurpleColor),
      ),
      filled: true,
    );
  }
}