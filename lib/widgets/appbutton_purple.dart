

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../localization/app_localization.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/text_styles.dart';

class AppButtonBorder extends StatefulWidget {
  Function onpressed;
  final String buttonText;
  final String buttonImage;
   AppButtonBorder({Key? key, required this.onpressed, required this.buttonText, required this.buttonImage}) : super(key: key);

  @override
  State<AppButtonBorder> createState() => _AppButtonBorderState();
}

class _AppButtonBorderState extends State<AppButtonBorder> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: (){
        widget.onpressed();
      },
      child: Container(
        height: queryData.size.height*0.06,
        width: queryData.size.width*0.8,
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppColors.whiteColor,
          border: Border.all(
            color: AppColors.mainPurpleColor,
            width: 2,
          ),),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Image.asset(widget.buttonImage,width: queryData.size.width*0.06,height: queryData.size.height*0.06,),
            SizedBox(
              width: queryData.size.width * 0.02,
            ),
            Text(
              getTranslated(context,
                  widget.buttonText) ??
                  "",
              style: AppTextStyle.ModernEra(
                AppColors.mainPurpleColor,
                13.sp,
                FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
