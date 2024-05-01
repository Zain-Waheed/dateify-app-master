import 'package:dateify_project/src/base_screen/home/view/home.dart';
import 'package:dateify_project/src/base_screen/settings/view/pages/blockedlist_page.dart';
import 'package:dateify_project/src/base_screen/settings/view/pages/contactus_page.dart';
import 'package:dateify_project/src/base_screen/settings/view/pages/membership_page.dart';
import 'package:dateify_project/src/base_screen/settings/view/pages/notification_page.dart';
import 'package:dateify_project/src/base_screen/settings/view/pages/privacy_policy_page.dart';
import 'package:dateify_project/src/base_screen/settings/view/pages/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import '../../home/view_model/home_vm.dart';
import '../view_model/setting_vm.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    //=========================
    PageController?  basePageViewController = PageController();
    return Consumer<SettingVM>(builder: (context,settingPro,_){
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 300,
              backgroundColor: AppColors.whiteColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(5),
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(top: 14.0, left: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          settingPro.settingPageIndex==0?Get.back():     settingPro.settingPageIndex=0;
                          settingPro.update();
                          setState(() {});
                        },
                        child: Image.asset(
                          AppImages.arrowback,width: queryData.size.width*0.08,height: queryData.size.height*0.06,
                        ),),
                    appBarTitle(settingPro),
                    // Text(
                    //   getTranslated(context, 'settings') ?? "",
                    //   style: AppTextStyle.ModernEra(
                    //     AppColors.blackColor,
                    //     20.sp,
                    //     FontWeight.w700,
                    //   ),
                    // ),
                  ],
                ),
              ),
              elevation: 0.3,
            ),
          ),
          body:IndexedStack(
            index:settingPro.settingPageIndex,
            children: const [
              SettingsPage(),
              NotificationPage(),
              MemberShipPage(),
              BlockedListPage(),
              PrivacyPolicyPage(),
              PrivacyPolicyPage(),
              PrivacyPolicyPage(),
            ],
          )
      );
    },);
  }
  appBarTitle(SettingVM settingsPro) {
    if(settingsPro.settingPageIndex==0)
    {
      return Text(
        getTranslated(context, 'settings') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    }else
    if(settingsPro.settingPageIndex==1)
    {
      return Text(
        getTranslated(context, 'notifications') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    }else
    if(settingsPro.settingPageIndex==2)
    {
      return Text(
        getTranslated(context, 'membership') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    } else  if(settingsPro.settingPageIndex==3)
    {
      return Text(
        getTranslated(context, 'blocked_list') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    } else  if(settingsPro.settingPageIndex==4)
    {
      return Text(
        getTranslated(context, 'contact_us') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    }else if(settingsPro.settingPageIndex==5)
    {
      return Text(
        getTranslated(context, 'privacy_policy') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    }else if(settingsPro.settingPageIndex==6)
    {
      return Text(
        getTranslated(context, 'terms_conditions') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    }else if(settingsPro.settingPageIndex==7)
    {
      return Text(
        getTranslated(context, 'cookie_policy') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    }
  }
}
