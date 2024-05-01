



import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import '../../../../widgets/appbutton_purple.dart';
import '../../search/view/search.dart';
import '../view/pages/new_post.dart';

class NoGroupsWidget extends StatefulWidget {
  const NoGroupsWidget({Key? key}) : super(key: key);

  @override
  State<NoGroupsWidget> createState() => _NoGroupsWidgetState();
}

class _NoGroupsWidgetState extends State<NoGroupsWidget> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Column(
      children: [
        SizedBox(
          height: queryData.size.height * 0.15,
        ),
        Center(
          child: Container(
            height: queryData.size.height * 0.3,
            width: queryData.size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(
                  width: 1,
                  color: AppColors
                      .greyColor //                   <--- border width here
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor,
                  spreadRadius: -1,
                  blurRadius: 1,
                  offset: Offset(0, 6), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30),
                  width: queryData.size.width * 0.8,
                  child: Column(
                    children: [
                      //---Title
                      SizedBox(
                        width: queryData.size.width * 0.5,
                        child: Text(
                          getTranslated(
                              context, 'you_dont_have_any_groups_yet') ??
                              "",
                          style: AppTextStyle.ModernEra(
                            AppColors.blackColor,
                            20.sp,
                            FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.01,
                      ),
                      //---SubTitle
                      SizedBox(
                        width: queryData.size.width * 0.6,
                        child: Text(
                          getTranslated(context,
                              'search_for_a_first_group_and_let_get') ??
                              "",
                          style: AppTextStyle.ModernEra(
                            AppColors.darkGreyColor,
                            13.sp,
                            FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                AppButtonBorder(onpressed:(){
                  Get.to(SearchView());
                }, buttonText: 'search_group', buttonImage: AppImages.serarchPruple,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
