

import 'package:dateify_project/src/auth/view/singup/personel_info.dart';
import 'package:dateify_project/src/auth/view/singup/phone_view.dart';
import 'package:dateify_project/src/auth/view/widgets/auth_widget.dart';
import 'package:dateify_project/src/base_screen/home/view_model/home_vm.dart';
import 'package:dateify_project/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../backend/api_request.dart';
import '../../../../localization/app_localization.dart';
import '../../../../models/user_model.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/text_styles.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/validation.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../base_screen/home/view/home.dart';
import '../../view_model/auth_vm.dart';
import '../widgets/app_button.dart';

class OtpView extends StatefulWidget {
  final bool isLogin;
  const OtpView({Key? key, required this.isLogin}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String? otpText;
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool greyButton=true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<AuthVM>(builder: (context,authPro,_){
      return Stack(
        children:[
          AuthWidget(
            funBody: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.width * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getTranslated(context,'confirm_number')??"",
                      style: AppTextStyle.ModernEra(
                        AppColors.blackColor,
                        20.sp,
                        FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Get.offAllNamed(PhoneView.route);
                      },
                      child: Text(getTranslated(context,'edit')??"",
                        style: AppTextStyle.ModernEra(
                          AppColors.mainPurpleColor,
                          15.sp,
                          FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Text("Send to "+authPro.phoneController.text,
                  style: AppTextStyle.ModernEra(
                    AppColors.darkGreyColor,
                    12.sp,
                    FontWeight.w400,
                  ),
                ),
                SizedBox(height: Get.width * 0.08),
                Center(
                  child: SizedBox(
                    // color: AppColors.blueColor,
                    width: queryData.size.width*0.7,
                    child: Form  (
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: PinCodeTextField(
                        textStyle:AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          20.sp,
                          FontWeight.w500,
                        ),
                        appContext: context,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        boxShadows: [
                          BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.2), offset: Offset(0, 4), blurRadius: 5.0)
                        ],
                        controller: otpController,
                        length: 4,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        enableActiveFill: true,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          inactiveColor: AppColors.whiteColor,
                          activeColor: AppColors.whiteColor,
                          selectedColor: AppColors.mainPurpleColor,
                          activeFillColor: AppColors.whiteColor,
                          inactiveFillColor: AppColors.whiteColor,
                          disabledColor: AppColors.darkGreyColor,
                          errorBorderColor: AppColors.greyColor,
                          selectedFillColor: AppColors.whiteColor,
                          borderWidth: 0.2,
                          fieldHeight: queryData.size.height * 0.07,
                          fieldWidth: queryData.size.width * 0.15,
                          // fieldOuterPadding:EdgeInsets.only(right: Get.width * 0.012)
                        )  ,
                        animationDuration: const Duration(milliseconds: 300),
                        //  backgroundColor: Colors.white,
                        validator: (value) =>
                            FieldValidator.validateOTP(otpController.text),
                        onCompleted: (value)
                        {
                        },
                        onChanged: (value) {
                          if(int.parse(value.length.toString())<4)
                          {
                            setState(() {
                              greyButton=true;
                            });
                          }else
                          {
                            setState(() {
                              greyButton=false;
                            });
                          }
                          setState(() {
                            otpText = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: TextButton(
                    onPressed: (){
                      Get.toNamed(PhoneView.route);
                    },
                    child: Text(getTranslated(context,'didn_get_the_code?')??"",
                      style: AppTextStyle.ModernEra(
                        AppColors.mainPurpleColor,
                        15.sp,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(child: AppButton(
                  buttonText: 'confirm',
                  onpressed: (){
                    validateOTp(authPro);
                  },
                  width: queryData.size.width*0.85,
                  isWhite: greyButton==true?true:false,
                ),),
                SizedBox(
                  height: queryData.size.height*0.06,
                ),
              ],
            ),
          ),
          if (isLoading)
          LoadingWidget(),
        ]
      );
    },);
  }

  void validateOTp(AuthVM authPro) {
    String phone_number = "${authPro.phoneController.text}";
    String cleaned_number = phone_number.replaceAll("-", "");
    print(cleaned_number);
    setState(() {
      isLoading=true;
    });
    Services.postApi(
        {
          "otp":otpController.text,
          "phone":"+92${cleaned_number}",
        },
        widget.isLogin==false?"/validate-register-otp":"/validate-login-otp"
    ).then((response) async{
      setState(() {
        isLoading=false;
      });
      final data=response;
    final match = data["success"];
      if(match==true){
        Helper.ToastFlutter(data["description"]);
        //=========Login View=====================
        if(widget.isLogin==true){
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('isLogin', 'true');
          print("******Token***********${data["content"]["token"]}");
          prefs.setString('token', data["content"]["token"]);
          print("******Token***********${data["content"]["user"]}");
          UserModel  userModel =UserModel.fromJson(data);
          var model = Provider.of<AuthVM>(context, listen: false);
          model.userModel=userModel.content.user;
          Get.offAllNamed(HomeView.route);
        }else
          {
            //======Sinup OTP=====================
            Get.offAllNamed(PersonelinfoView.route);
          }
      }else
      {
        Helper.ToastFlutter(data["description"]);
      }
    });
  }
}
