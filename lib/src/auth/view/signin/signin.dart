

import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../backend/api_request.dart';
import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/text_styles.dart';
import '../../../../utils/helper.dart';
import '../../../../widgets/loading_widget.dart';
import '../singup/opt_view.dart';
import '../singup/phone_view.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_widget.dart';

class SignInView extends StatefulWidget {
  static String route = '/signInView';
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  PhoneNumber number=PhoneNumber(isoCode: "US");
  bool validated=false;
  FocusNode focus = FocusNode();
  List<String> countries=["US","CA"];
  String initialCountry = 'US';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<AuthVM>(builder: (context,authPro,_){
      return Scaffold(
          body: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(
              children:[
                AuthWidget(
                    funBody:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: queryData.size.height*0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getTranslated(context,'sign_in_')??"",
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
                              child: Text(getTranslated(context,'sign_up_')??"",
                                style: AppTextStyle.ModernEra(
                                  AppColors.mainPurpleColor,
                                  15.sp,
                                  FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        Text(getTranslated(context,'enter_your_number_and_we_send_you_a_verification_code')??"",
                          style: AppTextStyle.ModernEra(
                            AppColors.darkGreyColor,
                            12.sp,
                            FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: queryData.size.height*0.02,
                        ),
                        Text(getTranslated(context,'phone_number')??"",
                          style: AppTextStyle.ModernEra(
                            AppColors.blackColor,
                            12.sp,
                            FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: queryData.size.height*0.01,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: Get.width * 0.14,
                              width: Get.width*0.9,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: focus.hasFocus?AppColors.greyColor:AppColors.darkGreyColor),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: Get.width * 0.14,
                                width: Get.width*0.003,
                                color: focus.hasFocus?AppColors.greyColor:AppColors.darkGreyColor,
                                margin: EdgeInsets.only(right: Get.width*0.3),

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 5,right: 10),
                              child: Form(
                                child: InternationalPhoneNumberInput(
                                  countries: countries,
                                  autoFocus: true,
                                  focusNode: focus,
                                  spaceBetweenSelectorAndTextField:0,
                                  selectorButtonOnErrorPadding:0,
                                  key: Key('phone_number'),
                                  inputDecoration: InputDecoration(
                                    hintText: getTranslated(context, 'enter_number'??""),
                                    // suffixIcon: validated==true?Container(
                                    //   margin: EdgeInsets.only(right: Get.width*0.03),
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       color: AppColors.green
                                    //   ),
                                    //   child: Center(
                                    //     child: Image.asset(AppImages.tick,scale: 2,),
                                    //   ),
                                    // ):SizedBox(),
                                    suffixIconConstraints: BoxConstraints(
                                      maxHeight: Get.width*0.05,
                                      maxWidth: Get.width*0.1,
                                    ),
                                    hintStyle: AppTextStyle.ModernEra(AppColors.darkGreyColor, Get.width*0.04, FontWeight.w500),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(color:Colors.transparent),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    focusedErrorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(color:Colors.transparent),
                                    ),
                                    isDense: true,
                                  ),
                                  inputBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.darkGreyColor,style: BorderStyle.solid)
                                  ),
                                  onInputChanged: (number) {
                                    setState(() {

                                    });
                                  },
                                  onInputValidated: (bool value) {
                                    validated=value;
                                    setState(() {

                                    });
                                  },
                                  selectorConfig: const SelectorConfig(
                                    leadingPadding: 2,
                                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                    showFlags: true,
                                  ),
                                  ignoreBlank: false,
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  selectorTextStyle: AppTextStyle.ModernEra(AppColors.darkGreyColor, Get.width*0.04, FontWeight.w500),
                                  textFieldController: authPro.phoneController,
                                  countrySelectorScrollControlled: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Center(child: AppButton(
                          buttonText: 'send_code',
                          onpressed: (){
                            sendOTP(authPro);
                          },
                          width: queryData.size.width*0.85,
                          isWhite: validated==false?true:false,
                        ),),
                        SizedBox(
                          height: queryData.size.height*0.06,
                        ),
                      ],
                    )
                ),
                if (isLoading)
                  LoadingWidget(),
              ]
            ),
          )
      );
    });
  }
  void sendOTP(AuthVM authPro) {
    String phone_number = "${authPro.phoneController.text}";
    String cleaned_number = phone_number.replaceAll("-", "");
    print(cleaned_number);
    setState(() {
      isLoading=true;
    });
    Services.postApi(
        {
          "phone": "+1${cleaned_number}",
        },
        "/login"
    ).then((response){
      setState(() {
        isLoading=false;
      });
      final data=response;
      if(data["success"]==true){
        // authPro.generatedOtp=data["content"]["otp"];
        // authPro.notifyListeners();
        print("**********${data["content"]["otp"]}");
        Get.to(OtpView(isLogin: true,));
      }else
      {
        Helper.ToastFlutter( data["description"]);
      }
      print("-Sign In--${response}");
    });
  }
}
