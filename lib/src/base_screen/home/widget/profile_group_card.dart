
import 'package:dateify_project/src/base_screen/home/model/group_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';

class ProfileGroupCard extends StatefulWidget {
 DatumGroups datumGroups;
 final Function onpressed;
 ProfileGroupCard({Key? key, required this.onpressed, required this.datumGroups}) : super(key: key);

  @override
  State<ProfileGroupCard> createState() => _ProfileGroupCardState();
}

class _ProfileGroupCardState extends State<ProfileGroupCard> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      height: queryData.size.height * 0.14,
      width: queryData.size.width,
      margin: EdgeInsets.symmetric(horizontal: 20)+EdgeInsets.only(bottom: 15),
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
      child: Row(
        children: [
          Container(
              height: queryData.size.height * 0.14,
              width: 100,
              margin: EdgeInsets.only(right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.datumGroups.avatar,
                  fit: BoxFit.cover,
                ),
              )),
          Expanded(
            child: Padding(
              padding:EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.datumGroups.name,
                    style: AppTextStyle.ModernEra(
                      AppColors.darkblackColor,
                      14.sp,
                      FontWeight.w500,
                    ),
                  ),
                  Text(
                     widget.datumGroups.totalMembers.toString()+' members',
                    style: AppTextStyle.ModernEra(
                      AppColors.darkGreyColor,
                      12.sp,
                      FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                   widget.onpressed();
                    },
                    child: Text(getTranslated(context,'leave_group')??"",
                      style: AppTextStyle.ModernEra(
                        AppColors.mainPurpleColor,
                        12.sp,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
