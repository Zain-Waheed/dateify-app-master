import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:dateify_project/src/auth/view/singup/read_rules.dart';
import 'package:dateify_project/src/auth/view/singup/rules.dart';
import 'package:http/http.dart' as http;
import 'package:dateify_project/resources/app_images.dart';
import 'package:dateify_project/src/auth/view/singup/verify_id.dart';
import 'package:dateify_project/src/auth/view/widgets/app_button.dart';
import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:sizer/sizer.dart';
import 'package:dropdown_cupertino/dropdown_cupertino.dart';
import '../../../../backend/api_request.dart';
import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/input.decorations.dart';
import '../../../../resources/text_styles.dart';
import '../../../../utils/validation.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../widgets/custom_listTile.dart';
import '../../../../widgets/loading_widget.dart';
import '../widgets/auth_widget.dart';

class PersonelinfoView extends StatefulWidget {
  static String route = '/personelinfoView';
  const PersonelinfoView({Key? key}) : super(key: key);

  @override
  State<PersonelinfoView> createState() => _PersonelinfoViewState();
}

// enum Person {
//   yakup,
//   burak,
//   ramazan,
// }
// Map<Person?, String> personMap = {
//   null: "INITIAL",
//   Person.yakup: "YAKUP",
//   Person.ramazan: "RAMAZAN",
//   Person.burak: "BURAK"
// };

final items = [
  'Male',
  'Female',
];
int genderIndex = 0;
DateTime personelInfoDateTime = DateTime.now();
String dob = DateFormat('MMM dd').format(DateTime.now()).toString();

class _PersonelinfoViewState extends State<PersonelinfoView> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  PlatformFile? pickedFile;
  bool isPicked=false;
  File imageFile = File("");
  bool shouldShow = false;
  double percent = 1.0;
  bool isLoading = false;
  //---------------------------
  bool _isBothFieldsFilled = false;
  //===========================================================
  void _checkIfBothFieldsFilled() {
    // Update the boolean variable based on whether both fields have non-empty values
    setState(() {
      _isBothFieldsFilled =
          nameController.text.isNotEmpty && usernameController.text.isNotEmpty
              &&genderController.text.isNotEmpty&&dobController.text.isNotEmpty;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    nameController.addListener(_checkIfBothFieldsFilled);
    usernameController.addListener(_checkIfBothFieldsFilled);
    genderController.addListener(_checkIfBothFieldsFilled);
    dobController.addListener(_checkIfBothFieldsFilled);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<AuthVM>(builder: (context,authPro,_){
      return Scaffold(
        floatingActionButton: Padding(
          padding:  EdgeInsets.only(bottom: 20,left: 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AppButton(
                buttonText: 'continue',
                onpressed: () {
                  // Get.to(VerifyIDView());
                  if(pickedFile?.path == null){
                    Helper.ToastFlutter("Please upload a profile picture");
                  }
                  if(authPro.formKey.currentState!.validate()&&pickedFile?.path != null)
                  {
                    registerUser(authPro);
                  }
                },
                width: queryData.size.width * 1,
                isWhite: !_isBothFieldsFilled),
          ),
        ),
        body: Container(
          color: AppColors.greyColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: queryData.size.height*0.03,
                ),
                Image.asset(AppImages.logoPurple,
                  height:queryData.size.height*0.06,
                  width: queryData.size.width*0.2,),
                Text(getTranslated(context,'dateify')??"",
                  style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    20.sp,
                    FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height*0.03,
                ),
                Container(
                  width: queryData.size.width,
                  padding: const EdgeInsets.symmetric(horizontal:24),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: queryData.size.height * 0.03,
                      ),
                      Text(
                        getTranslated(context, 'personal_info') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.blackColor,
                          20.sp,
                          FontWeight.w700,
                        ),
                      ),
                      Text(
                        getTranslated(context,
                            'you_can_remain_anonymous_by_changing_your_settings') ??
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
                      Form(
                        key: authPro.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context, 'name') ?? "",
                              style: AppTextStyle.ModernEra(
                                AppColors.blackColor,
                                12.sp,
                                FontWeight.w600,
                              ),
                            ),
                            //---Name
                            SizedBox(
                              height: queryData.size.height * 0.01,
                            ),
                            TextFormField(
                              controller: nameController,
                              cursorColor: AppColors.mainPurpleColor,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) =>
                                  FieldValidator.validateName(nameController.text),
                              decoration: AppInputDecoration.circularFieldDecoration(
                                null,
                                'enter_name',
                                null,
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            //---User Name
                            Text(
                              getTranslated(context, 'username') ?? "",
                              style: AppTextStyle.ModernEra(
                                AppColors.blackColor,
                                12.sp,
                                FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.01,
                            ),
                            TextFormField(
                              controller: usernameController,
                              cursorColor: AppColors.mainPurpleColor,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              validator: (value) =>
                                  FieldValidator.validateEmailUserName(usernameController.text),
                              decoration: AppInputDecoration.circularFieldDecoration(
                                null,
                                'enter_username',
                                null,
                              ),
                            ),
                            //---Gender
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            Text(
                              getTranslated(context, 'gender') ?? "",
                              style: AppTextStyle.ModernEra(
                                AppColors.blackColor,
                                12.sp,
                                FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.01,
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: genderController,
                              cursorColor: AppColors.themeColor,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value)=>FieldValidator.validateGender(genderController.text),
                              decoration: AppInputDecoration.circularFieldDecoration(
                                null,
                                'select_gender',
                                Image.asset(AppImages.dropdownIcon),
                              ),
                              onTap: () {
                                genderController.text=items[0].toString();
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      cancelButton: CupertinoActionSheetAction(
                                          child: Text('save'),
                                          onPressed: () {
                                            WidgetsBinding
                                                .instance.focusManager.primaryFocus
                                                ?.unfocus();
                                            Navigator.pop(context);
                                          }),
                                      actions: [buildPicker()],
                                    ));
                              },
                            ),
                            //---Calender
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            Text(
                              getTranslated(context, 'date_of_birth') ?? "",
                              style: AppTextStyle.ModernEra(
                                AppColors.blackColor,
                                12.sp,
                                FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.01,
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: dobController,
                              cursorColor: AppColors.themeColor,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.datetime,
                              textInputAction: TextInputAction.next,
                              validator: (value)=>FieldValidator.validateDateOfBirth(dobController.text),
                              decoration: AppInputDecoration.circularFieldDecoration(
                                null,
                                'select_date_of_birth',
                                null,
                              ),
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      //---Profile Picture
                      SizedBox(
                        height: queryData.size.height * 0.02,
                      ),
                      Text(
                        getTranslated(context, 'profile_photo') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.blackColor,
                          12.sp,
                          FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.01,
                      ),
                      Container(
                        width: queryData.size.width,
                        height: shouldShow == true
                            ? queryData.size.height * 0.12
                            : queryData.size.height * 0.08,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(
                              width: 1,
                              color: AppColors
                                  .greyColor //                   <--- border width here
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: AppColors.greyColor,
                          //     spreadRadius: -1,
                          //     blurRadius: 1,
                          //     offset: Offset(0, 6), // changes position of shadow
                          //   ),
                          // ],
                        ),
                        child: isPicked!=false
                            ? pictureUpload(queryData)
                            : GestureDetector(
                          onTap: () {
                            pickFile();
                          },
                          child: Row(
                            children: [
                              Container(
                                // color:AppColors.blackColor,
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                    AppImages.uploadImg,
                                    width: 60,
                                    height: 100,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      pickFile();
                                    },
                                    child: Text(
                                      getTranslated(context, 'click_to_upload') ??
                                          "",
                                      style: AppTextStyle.ModernEra(
                                        AppColors.mainPurpleColor,
                                        15.sp,
                                        FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: queryData.size.height * 0.01,
                                  ),
                                  Text(
                                    "SVG, PNG, JPG or GIF (max. 800x400px)",
                                    style: AppTextStyle.ModernEra(
                                      AppColors.darkGreyColor,
                                      8.sp,
                                      FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }


  //======================Picked File==========================
  pictureUpload(MediaQueryData queryData) => Column(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: shouldShow == true
                  ? Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Image.asset(
                      AppImages.uploadingImg,
                      height: queryData.size.height,
                      width:  queryData.size.width*0.06,
                    ),
                  ),):
              CircleAvatar(
                backgroundImage: FileImage(File(pickedFile!.path!)),
                radius: 25, // change the radius to adjust the size of the image
              ),
              // : Container(
              //     width: queryData.size.width * 0.12,
              //     height: queryData.size.height * 0.16,
              //     margin: EdgeInsets.symmetric(vertical: 5),
              //     // color: Colors.red,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(70),
              //       child: Image.file(
              //         imageFile,
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   ),
              title: SizedBox(
                width: 100,
                child: Text(
                  pickedFile!.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.ModernEra(
                    AppColors.mainPurpleColor,
                    10.sp,
                    FontWeight.w500,
                  ),
                ),
              ),
              subtitle: Text(
                pickedFile!.size.toString(),
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.ModernEra(
                  AppColors.mainPurpleColor,
                  10.sp,
                  FontWeight.w500,
                ),
              ),
              trailing: Container(
                width: 50,
                child: InkWell(
                    onTap: (){
                      setState(() {
                        isPicked=false;
                        print("Delete Delete");
                      });
                    },
                    child: Image.asset(AppImages.deleteIcon,height: queryData.size.height*0.03,),),
              ),
              enabled:false,
            ),
          ),
          SizedBox(
            height: queryData.size.height * 0.02,
          ),
          shouldShow == true
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 10.0,
                          animationDuration: 3000,
                          percent: percent,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: AppColors.mainPurpleColor,
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.02,
                      ),
                      Text(
                        percent.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.ModernEra(
                          AppColors.mainPurpleColor,
                          10.sp,
                          FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: queryData.size.height * 0.02,
          ),
        ],
      );
  //========Pick Gender=-======================================
  Widget buildPicker() => SizedBox(
        height: 150,
        child: CupertinoPicker(
          itemExtent: 50,
          onSelectedItemChanged: (int value) {
            setState(() {
              genderIndex = value;
              genderController.text = items[genderIndex];
            });
          },
          children: items
              .map(
                (item) => Center(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontFamily: 'ModernEra',
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
  //===========================================================
  //======================Select Date==========================
  _selectDate(BuildContext? context) async {
    // FocusScope.of(context!).requestFocus(new FocusNode());
    final DateTime? selected = await showDatePicker(
      context: context!,
      initialDate: personelInfoDateTime,
      lastDate: personelInfoDateTime,
      locale: const Locale('en', 'US'),
      firstDate: DateTime(
          personelInfoDateTime.year - 100,
          personelInfoDateTime.month,
          personelInfoDateTime.day,
          personelInfoDateTime.hour,
          personelInfoDateTime.minute),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.mainPurpleColor,
            colorScheme: ColorScheme.light(primary: AppColors.mainPurpleColor),
          ),
          child: child!,
        );
      },
    );
    if (selected != null) {
      setState(() {
        personelInfoDateTime = selected;
        var outputFormat = DateFormat('dd-MM-yyyy');
        // dob = DateFormat.MMMd().format(personelInfoDateTime);
        var outputDate = outputFormat.format(personelInfoDateTime);
        dobController.text = outputDate;
      });
    }
  }

//==================================================================
  //===================File Picker===================================
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg'],
    );
    if (result != null) {
      isPicked=true;
      pickedFile = result.files.first;
      imageFile = File(result.files.first.path ?? "");
      setState(() {
        shouldShow = true;
      });
      Timer timer = Timer(Duration(seconds: 3), () {
        setState(() {
          shouldShow = false;
        });
      });
      // Get.back(result: result);
    } else {
      // User canceled the picker
    }
  }

//===================================================================
//===================Register APi====================================
  void registerUser(AuthVM authPro)async{
    String phone_number = "${authPro.phoneController.text}";
    String cleaned_number = phone_number.replaceAll("-", "");
    print(cleaned_number);
    setState(() {
      isLoading=true;
    });

    Services.postRegister(
        {
          "name":nameController.text,
          "username":usernameController.text,
          "dob":dobController.text,
          "gender":genderController.text,
          "phone":"+1${cleaned_number}",
        },pickedFile!,
        "/register"
    ).then((response){
      setState(() {
        isLoading=false;
      });
      final data=response;
        final match=data["success"];
        if(match==true){
          Helper.ToastFlutter(data["description"]);
          Get.toNamed(ReadRules.route);
        }else
        {
          var errorsMap = response['errors'];
          var errorMessageString = '';
          errorsMap.forEach((key, value) {
            // Get the error message(s) for this key
            var errorMessages = value as List<dynamic>;

            // Concatenate the key and each error message into a formatted string
            var formattedErrors = errorMessages
                .map((errorMessage) => ' $errorMessage')
                .join('\n');

            // Append the formatted errors to the error message string
            errorMessageString += formattedErrors + '\n';
          });
          Helper.ToastFlutter( errorMessageString);
        }
    });

    //
    // Services.postApi(
    //     {
    //       "name":"Ali",
    //       "username":"W",
    //       "dob":"12-2-2000",
    //       "gender":"Male",
    //       "phone":"+923040319389",
    //       "photo":imageFile.toString(),
    //     },
    //     "/register"
    // ).then((response){
    //   final data=response;
    //   final match=data["success"];
    //   if(match==true){
    //     Helper.ToastFlutter(data["description"]);
    //     Get.to(PersonelinfoView());
    //   }else
    //   {
    //     Helper.ToastFlutter(data["description"]);
    //   }
    //   print(response);
    // });
  }
}

