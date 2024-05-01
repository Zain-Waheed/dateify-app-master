

import 'package:dateify_project/src/base_screen/settings/view/pages/contactus_page.dart';
import 'package:dateify_project/src/base_screen/settings/view_model/setting_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_images.dart';
import '../../../../../resources/text_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<SettingVM>(builder: (context,settingPro,_){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: queryData.size.height*0.01,
            ),
            Column(
              children:ListTile.divideTiles(
                  context: context,
                  tiles: [
                    //==Notification
                    ListTile(
                      onTap: (){
                        settingPro.settingPageIndex=1;
                        settingPro.update();
                      },
                      minLeadingWidth : 10,
                      leading:Image.asset(
                        AppImages.notificationPurple,width: queryData.size.width*0.08,height: queryData.size.height*0.06
                      ),
                      title: Text(
                        getTranslated(context, 'notification') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          14.sp,
                          FontWeight.w600,
                        ),
                      ),
                      trailing:Image.asset(AppImages.arrowSetting,width: queryData.size.width*0.08,height: queryData.size.height*0.06),
                    ),
                    //==Membership
                    ListTile(
                      onTap: (){
                        settingPro.settingPageIndex=2;
                        settingPro.update();
                      },
                      minLeadingWidth : 10,
                      leading:Image.asset(
                        AppImages.membership,
                          width: queryData.size.width*0.08,height: queryData.size.height*0.06
                      ),
                      title: Text(
                        getTranslated(context, 'membership') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          14.sp,
                          FontWeight.w600,
                        ),
                      ),
                      trailing:Image.asset(AppImages.arrowSetting,width: queryData.size.width*0.08,height: queryData.size.height*0.06),
                    ),
                    //==BlockedList
                    ListTile(
                      onTap: (){
                        settingPro.settingPageIndex=3;
                        settingPro.update();
                      },
                      minLeadingWidth : 10,
                      leading:Image.asset(
                        AppImages.block,
                          width: queryData.size.width*0.08,height: queryData.size.height*0.06
                      ),
                      title: Text(
                        getTranslated(context, 'blocked_list') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          14.sp,
                          FontWeight.w600,
                        ),
                      ),
                      trailing:Image.asset(AppImages.arrowSetting,width: queryData.size.width*0.08,height: queryData.size.height*0.06),
                    ),
                    //==Contact us
                    ListTile(
                      onTap: (){
                        Get.to(ContactUs());
                      },
                      minLeadingWidth : 10,
                      leading:Image.asset(
                        AppImages.commentPurple,
                          width: queryData.size.width*0.08,height: queryData.size.height*0.06
                      ),
                      title: Text(
                        getTranslated(context, 'contact_us') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          14.sp,
                          FontWeight.w600,
                        ),
                      ),
                      trailing:Image.asset(AppImages.arrowSetting,width: queryData.size.width*0.08,height: queryData.size.height*0.06),
                    ),
                    //==Privacy Policy
                    ListTile(
                      onTap: (){
                        settingPro.settingPageIndex=5;
                        settingPro.update();
                      },
                      minLeadingWidth : 10,
                      title: Text(
                        getTranslated(context, 'privacy_policy') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          14.sp,
                          FontWeight.w600,
                        ),
                      ),
                      trailing:Image.asset(AppImages.arrowSetting,width: queryData.size.width*0.08,height: queryData.size.height*0.06),
                    ),
                    //==Term and Conditions
                    ListTile(
                      onTap: (){
                        settingPro.settingPageIndex=6;
                        settingPro.update();
                      },
                      minLeadingWidth : 10,
                      title: Text(
                        getTranslated(context, 'terms_conditions') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          14.sp,
                          FontWeight.w600,
                        ),
                      ),
                      trailing:Image.asset(AppImages.arrowSetting,width: queryData.size.width*0.08,height: queryData.size.height*0.06),
                    ),
                    //==Cokkie Policy
                    ListTile(
                      onTap: (){
                        settingPro.settingPageIndex=7;
                        settingPro.update();
                      },
                      minLeadingWidth : 10,
                      title: Text(
                        getTranslated(context, 'cookie_policy') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkblackColor,
                          14.sp,
                          FontWeight.w600,
                        ),
                      ),
                      trailing:Image.asset(AppImages.arrowSetting,width: queryData.size.width*0.08,height: queryData.size.height*0.06),
                    ),
                  ]
              ).toList(),
            ),
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
    });
  }
}

