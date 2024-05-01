
import 'dart:io';

import 'package:dateify_project/src/auth/view/singup/verification_approved.dart';
import 'package:dateify_project/src/auth/view/widgets/app_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import '../widgets/auth_widget.dart';

class VerifyIDView extends StatefulWidget {
  static String route = '/verifyIDView';
  const VerifyIDView({Key? key}) : super(key: key);

  @override
  State<VerifyIDView> createState() => _VerifyIDViewState();
}

class _VerifyIDViewState extends State<VerifyIDView> {

  PlatformFile? pickedFile;
  File imageFile=File("");

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return  AuthWidget(
        funBody: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: queryData.size.height * 0.03,
            ),
            Row(
              children:[
                GestureDetector(
                  onTap: (){},
                  child: Image.asset(AppImages.arrowback,
                    height:queryData.size.height*0.05,
                    width: queryData.size.width*0.06,),
                ),
                Text(
                  getTranslated(context, 'verify_id') ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    20.sp,
                    FontWeight.w700,
                  ),
                ),
                Spacer(),
              pickedFile?.path!=null?  TextButton(
                  onPressed: (){},
                  child: Text(getTranslated(context,'retake_photo')??"",
                    style: AppTextStyle.ModernEra(
                      AppColors.mainPurpleColor,
                      15.sp,
                      FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ):SizedBox(),
              ]
            ),
            Text(
              getTranslated(context,
                  'scan_your_id_card') ??
                  "",
              style: AppTextStyle.ModernEra(
                AppColors.darkGreyColor,
                12.sp,
                FontWeight.w400,
              ),
            ),
            SizedBox(
              height: queryData.size.height * 0.02,
            ),
            //----Photo Taken---
            Container(
              height: queryData.size.height*0.25,
              width: queryData.size.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(
                    width: 1,
                    color:AppColors.greyColor//                   <--- border width here
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
              child: pickedFile?.path==null?
              GestureDetector(
                onTap: (){
                  pickFile();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.plus,
                      height: queryData.size.height*0.05,
                      width: queryData.size.width*0.09,),
                    Text(
                      getTranslated(context, 'take_photo_of_your_id_card') ?? "",
                      style: AppTextStyle.ModernEra(
                        AppColors.mainPurpleColor,
                        16.sp,
                        FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ):ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  imageFile,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            //------------------
            SizedBox(
              height: queryData.size.height * 0.02,
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  GestureDetector(
                    onTap: (){},
                    child: Image.asset(AppImages.infocircle,
                      height:queryData.size.height*0.05,
                      width: queryData.size.width*0.06,),
                  ),
                  SizedBox(
                    width: queryData.size.height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: queryData.size.height*0.05,
                    width: queryData.size.width*0.76,
                    child: Text(
                      getTranslated(context, 'verification_photo') ?? "",
                      style: AppTextStyle.ModernEra(
                        AppColors.darkGreyColor,
                        12.sp,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ]
            ),
            SizedBox(
              height: queryData.size.height * 0.02,
            ),
            AppButton(
                buttonText: 'continue',
                onpressed: (){
                  Get.to(VerificationApprovedView());
                },
                width: queryData.size.width,
                isWhite: pickedFile?.path==null?true:false,
            ),
            SizedBox(
              height: queryData.size.height * 0.04,
            ),
          ],
        )
    );
  }
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg'],
    );
    if (result != null) {
      pickedFile=result.files.first;
      imageFile=File(result.files.first.path??"");
      setState(() {
      });
      // Get.back(result: result);
    } else {
      // User canceled the picker
    }
  }
}
