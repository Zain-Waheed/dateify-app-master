import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sizer/sizer.dart';

import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_images.dart';
import '../../../../../resources/text_styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool newCommentToggle=false;
  bool groupToggle=false;
  bool marketingToggle=false;
  bool inAppNotiToggle=false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //---New Comment----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getTranslated(context, 'new_comment')??"",
                style:AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  14.sp,
                  FontWeight.w700,
                ),),
              FlutterSwitch(
                width: queryData.size.width * 0.15,
                height: queryData.size.height * 0.03,
                valueFontSize: queryData.size.height * 0.015,
                toggleSize: 30.0,
                activeToggleColor: AppColors.whiteColor,
                value: newCommentToggle,
                activeColor: AppColors.mainPurpleColor,
                inactiveColor: AppColors.greyColor,
                activeText: '',
                inactiveText: '',
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (val) async {
                  setState(() {
                    newCommentToggle=val;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(getTranslated(context, 'we_will_notify_you_of_comments')??"",
            style:AppTextStyle.ModernEra(
              AppColors.grey,
              12.sp,
              FontWeight.w400,
            ),),
          //-------------------------
          SizedBox(
            height: queryData.size.width*0.08,
          ),
          //---Group-----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getTranslated(context, 'group')??"",
                style:AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  14.sp,
                  FontWeight.w700,
                ),),
              FlutterSwitch(
                width: queryData.size.width * 0.15,
                height: queryData.size.height * 0.03,
                valueFontSize: queryData.size.height * 0.015,
                toggleSize: 30.0,
                activeToggleColor: AppColors.whiteColor,
                value: groupToggle,
                activeColor: AppColors.mainPurpleColor,
                inactiveColor: AppColors.greyColor,
                activeText: '',
                inactiveText: '',
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (val) async {
                  setState(() {
                    groupToggle=val;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(getTranslated(context, 'we_will_notify_you_of_new_posts')??"",
            style:AppTextStyle.ModernEra(
              AppColors.grey,
              12.sp,
              FontWeight.w400,
            ),),
          //-------------------------
          //-------------------------
          SizedBox(
            height: queryData.size.width*0.08,
          ),
          //---Marketing and Special offers-----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getTranslated(context, 'marketing_special_offers')??"",
                style:AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  14.sp,
                  FontWeight.w700,
                ),),
              FlutterSwitch(
                width: queryData.size.width * 0.15,
                height: queryData.size.height * 0.03,
                valueFontSize: queryData.size.height * 0.015,
                toggleSize: 30.0,
                activeToggleColor: AppColors.whiteColor,
                value: marketingToggle,
                activeColor: AppColors.mainPurpleColor,
                inactiveColor: AppColors.greyColor,
                activeText: '',
                inactiveText: '',
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (val) async {
                  setState(() {
                    marketingToggle=val;
                  });
                },
              ),
            ],
          ),
          //-------------------------
          //-------------------------
          SizedBox(
            height: queryData.size.width*0.08,
          ),
          //---In-App Notifications-----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getTranslated(context, 'in_app_notifications')??"",
                style:AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  14.sp,
                  FontWeight.w700,
                ),),
              FlutterSwitch(
                width: queryData.size.width * 0.15,
                height: queryData.size.height * 0.03,
                valueFontSize: queryData.size.height * 0.015,
                toggleSize: 30.0,
                activeToggleColor: AppColors.whiteColor,
                value: inAppNotiToggle,
                activeColor: AppColors.mainPurpleColor,
                inactiveColor: AppColors.greyColor,
                activeText: '',
                inactiveText: '',
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (val) async {
                  setState(() {
                    inAppNotiToggle=val;
                  });
                },
              ),
            ],
          ),
          //-------------------------
          //======================================================
          Spacer(),
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
            height: queryData.size.height*0.07,
          ),
        ],
      ),
    );
  }
}
