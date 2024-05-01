import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      color: AppColors.greyColor,
      width: queryData.size.width,
      height: queryData.size.height,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated(context, 'today') ?? "",
            style: AppTextStyle.ModernEra(
              AppColors.darkGreyColor,
              12.sp,
              FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: queryData.size.width,
            height: queryData.size.height*0.35,
            padding: EdgeInsets.symmetric(vertical: 10,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.whiteColor,
            ),
            child: ListView(
              children:ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                  ]
              ).toList(),
            ),
          ),

          //===================Yesterday Messages
          SizedBox(
            height: 20,
          ),
          Text(
            getTranslated(context, 'yesterday') ?? "",
            style: AppTextStyle.ModernEra(
              AppColors.darkGreyColor,
              12.sp,
              FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: queryData.size.width,
            height: queryData.size.height*0.42,
            padding: EdgeInsets.symmetric(vertical: 10,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.whiteColor,
            ),
            child: ListView(
              children:ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: queryData.size.width * 0.12,
                        height: queryData.size.height * 0.16,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // color: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(AppImages.profilePic),
                        ),
                      ),
                      title: Text(
                        'Your subscription needs to be renewed',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '1m ago',
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          13.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                  ]
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

