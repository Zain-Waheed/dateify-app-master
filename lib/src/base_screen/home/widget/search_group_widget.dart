

import 'package:dateify_project/widgets/appbutton_purple.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';

class SearchGroupWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final String btnIcon;
  final String btnText;
  final Function onpressed;
  const SearchGroupWidget({Key? key, required this.onpressed, required this.title, required this.subTitle, required this.btnIcon, required this.btnText}) : super(key: key);

  @override
  State<SearchGroupWidget> createState() => _SearchGroupWidgetState();
}

class _SearchGroupWidgetState extends State<SearchGroupWidget> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      color: AppColors.greyColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: queryData.size.height * 0.3,
              width: queryData.size.width,
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
                        Text(
                          getTranslated(
                              context, widget.title) ??
                              "",
                          style: AppTextStyle.ModernEra(
                            AppColors.blackColor,
                            20.sp,
                            FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          getTranslated(context,
                              widget.subTitle) ??
                              "",
                          style: AppTextStyle.ModernEra(
                            AppColors.darkGreyColor,
                            13.sp,
                            FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  AppButtonBorder(onpressed:()=> widget.onpressed, buttonText: widget.btnText, buttonImage: widget.btnIcon,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
