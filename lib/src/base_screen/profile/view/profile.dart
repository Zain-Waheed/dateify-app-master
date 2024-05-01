import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/src/base_screen/home/widget/post_widget.dart';
import 'package:dateify_project/src/base_screen/profile/view/edit_profile.dart';
import 'package:dateify_project/src/base_screen/profile/view/page/comment_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import 'page/group_section.dart';
import 'page/post_section.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int profileindex=0;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<AuthVM>(builder: (context,authPro,_){
      return Container(
        color: AppColors.greyColor,
        child: Column(
          children: [
            DefaultTabController(
              length: 3,
              child: Container(
                // height: queryData.size.height*0.18,
                width: queryData.size.width,
                color: AppColors.whiteColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Row(
                        children: [
                          Container(
                            // color: AppColors.redColor,
                            width: queryData.size.width * 0.2,
                            height: queryData.size.height * 0.092,
                            margin: EdgeInsets.only(right: 10),
                            // color: Colors.red,
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(authPro.userModel!.avatar),
                              radius: 25,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authPro.userModel!.name,
                                style: AppTextStyle.ModernEra(
                                  AppColors.darkblackColor,
                                  14.sp,
                                  FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: queryData.size.width*0.41,
                                child: Text(
                                  "@"+authPro.userModel!.username,
                                  style: AppTextStyle.ModernEra(
                                    AppColors.darkGreyColor,
                                    14.sp,
                                    FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(EditProfileView());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainPurpleColor,
                              minimumSize: Size(50, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              getTranslated(
                                context,
                                'edit_profile',
                              ) ??
                                  "",
                              style: AppTextStyle.ModernEra(
                                AppColors.whiteColor,
                                12.sp,
                                FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 3.0,
                            color:Color(0xff7771C6),
                          ),
                          insets: EdgeInsets.symmetric(horizontal:16.0)
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor:AppColors.mainPurpleColor,
                      labelColor: AppColors.blackColor,
                      labelStyle: AppTextStyle.ModernEra(
                        Colors.transparent,
                        14.sp,
                        FontWeight.w600,
                      ),
                      unselectedLabelColor: AppColors.darkGreyColor,
                      onTap: (x){
                        profileindex=x;
                        setState(() {

                        });
                      },
                      tabs: <Tab>[
                        Tab(
                          text: getTranslated(context, "groups"),
                        ),
                        Tab(
                          text: getTranslated(context, "posts"),
                        ),
                        Tab(
                          text: getTranslated(context, "comments"),
                        ),
                      ],)
                  ],
                ),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: profileindex,
                children: const [
                  GroupSection(),
                  PostSection(),
                  CommentSection(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
