import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_images.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../auth/view/widgets/app_button.dart';

class ContactUsBottomsheet extends StatefulWidget {
   Function onPressed;
  ContactUsBottomsheet({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<ContactUsBottomsheet> createState() => _ContactUsBottomsheetState();
}

class _ContactUsBottomsheetState extends State<ContactUsBottomsheet> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      width: queryData.size.width,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset(AppImages.cross,color: AppColors.blackColor,))
            ],
          ),
          Text(getTranslated(context, 'thank_you_for_your_request')??""
            ,style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              18.sp,
              FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: queryData.size.height*0.02,
          ),
          Text(getTranslated(context, 'you_will_be_notified_when_we_respond')??""
            ,style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              14.sp,
              FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: queryData.size.height*0.06,
          ),
          AppButton
            (
              buttonText: 'ok',
              onpressed: (){
               widget.onPressed();
                Navigator.of(context).pop();
              },
              width: queryData.size.width,
              isWhite: false
          ),
          SizedBox(
            height: queryData.size.height*0.04,
          ),
        ],
      ),
    );
  }
}
