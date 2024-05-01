import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';

class CommnetsWidget2 extends StatefulWidget {
  final String? description;
  final bool isImage;
  CommnetsWidget2(
      {Key? key,
      required this.isImage,
      this.description})
      : super(key: key);

  @override
  State<CommnetsWidget2> createState() => _CommnetsWidget2State();
}

class _CommnetsWidget2State extends State<CommnetsWidget2> {
  String _selectedOption = 'Option 1';
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: queryData.size.width * 0.12,
              height: queryData.size.height * 0.1,
              margin: EdgeInsets.symmetric(vertical: 5),
// color: Colors.red,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.asset(AppImages.postpic),
              ),
            ),
            title: Row(
              children: [
                Text(
                  'Anonymos',
                  style: AppTextStyle.ModernEra(
                    AppColors.darkblackColor,
                    14.sp,
                    FontWeight.w500,
                  ),
                ),
                Text(
                  '@kateishere',
                  style: AppTextStyle.ModernEra(
                    AppColors.darkGreyColor,
                    12.sp,
                    FontWeight.w500,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              '5 hours ago',
              style: AppTextStyle.ModernEra(
                AppColors.darkGreyColor,
                12.sp,
                FontWeight.w500,
              ),
            ),
            trailing: PopupMenuButton<String>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              icon: Image.asset(AppImages.moreIcon),
              color: AppColors.dropDownColor,
              padding: EdgeInsets.zero,
              onSelected: (String value) {
                setState(() {
                  _selectedOption = value;
                });
                print("*****The Selected VAlue is ${value}");
                if (value == 'Option 1') {
                  _showDialog(
                      'Block @monika',
                      '@monika will no longer be able to view  your post and you will not be able to view posts from @monika',
                      'cancel', () {
                    Navigator.of(context).pop();
                  }, 'block', () {});
                } else {
                  _showDialog(
                      'Delete comment from @monika',
                      'Comment from @monika will no longer be visible under your post',
                      'cancel', () {
                    Navigator.of(context).pop();
                  }, 'delete', () {});
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                    value: 'Option 1',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Block @monika',
                          style: AppTextStyle.ModernEra(
                              AppColors.blackColor, 14.sp, FontWeight.w600),
                        ),
                        Image.asset(AppImages.blockBlack),
                      ],
                    )),
                PopupMenuItem<String>(
                  value: 'Option 2',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: queryData.size.width * 0.5,
                        child: Text(
                          'Report comment from @monika',
                          style: AppTextStyle.ModernEra(
                              AppColors.blackColor, 14.sp, FontWeight.w600),
                        ),
                      ),
                      Image.asset(AppImages.flag),
                    ],
                  ),
                ),
              ],
            ),
// GestureDetector(
//   onTap: (){
//     widget.moreOnPressed();
//     setState(() {
//
//     });
//   },
//   child: Padding(
//       padding: EdgeInsets.only(bottom: 20),
//       child: Image.asset(AppImages.moreIcon)),
// ),
          ),
          Text(
            widget.description ?? "",
            style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              12.sp,
              FontWeight.w500,
            ),
          ),
          SizedBox(
            height: queryData.size.height * 0.01,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: queryData.size.width * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImages.commentIcon),
                Padding(
                  padding: EdgeInsets.only(top: 4, left: 4),
                  child: Text(
                    '14',
                    style: AppTextStyle.ModernEra(
                      AppColors.darkGreyColor,
                      12.sp,
                      FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
//-----Dis Like
                Image.asset(AppImages.likeFlag),
                Text(
                  '14',
                  style: AppTextStyle.ModernEra(
                    AppColors.greenColor,
                    12.sp,
                    FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: queryData.size.width * 0.05,
                ),
//-----Like
                Image.asset(AppImages.dilikeFlag),
                Text(
                  '14',
                  style: AppTextStyle.ModernEra(
                    AppColors.redColor,
                    12.sp,
                    FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//------------------------------
  _showDialog(String title, String description, String btnOneText,
      Function()? onCancle, String btnTwoText, Function()? onTap2) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Text(
                title ?? "",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  17.sp,
                  FontWeight.w600,
                ),
              ),
              content: Text(
                description ?? "",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  13.sp,
                  FontWeight.w400,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: onCancle,
                  child: Text(
                    getTranslated(context, btnOneText) ?? "",
                    style: AppTextStyle.ModernEra(
                      AppColors.blueColor,
                      17.sp,
                      FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onTap2,
                  child: Text(
                    getTranslated(context, btnTwoText) ?? "",
                    style: AppTextStyle.ModernEra(
                      AppColors.redColor,
                      17.sp,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
