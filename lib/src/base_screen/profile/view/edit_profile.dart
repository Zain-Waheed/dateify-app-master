
import 'dart:io';

import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/src/base_screen/home/view/home.dart';
import 'package:dateify_project/utils/helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../backend/api_request.dart';
import '../../../../localization/app_localization.dart';
import '../../../../models/user_model.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/input.decorations.dart';
import '../../../../resources/text_styles.dart';
import '../../../../utils/validation.dart';
import '../../../../widgets/loading_widget.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameControllerProfile= TextEditingController();
  TextEditingController usernameControllerProfile=TextEditingController();
  //-----------------------------------------------------------------------
  PlatformFile? pickedFile;
  File imageFile = File("");
  //-----------------------------------------------------------------------
  bool isLoading=false;
  List<String> options =[];
  String? selectedOption;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var authPro=Provider.of<AuthVM>(context,listen: false);
      nameControllerProfile.text=authPro.userModel!.name;
      usernameControllerProfile.text=authPro.userModel!.username;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<AuthVM>(builder: (context,authPro,_){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.greyColor,
          elevation: 0,
          leadingWidth: 100,
          leading: TextButton(
            onPressed: (){
              Get.to(HomeView());
            },
            child: Text(getTranslated(context,'cancel')??"",
              style: AppTextStyle.ModernEra(
                AppColors.blackColor,
                15.sp,
                FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          title: Text(getTranslated(context,'edit_profile')??"",
            style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              22.sp,
              FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  if(pickedFile!=null){
                    editProfile();
                  }else{
                    Helper.ToastFlutter("Please select a Profile Picture");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainPurpleColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  getTranslated(
                    context,
                    'save',
                  ) ??
                      "",
                  style: AppTextStyle.ModernEra(
                    AppColors.whiteColor,
                    12.sp,
                    FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: Stack(
          children:[ Container(
            width: queryData.size.width,
            color: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: queryData.size.height * 0.015,
                ),
                pickedFile?.path==null?
                GestureDetector(
                  onTap: (){
                    pickFile();
                  },
                  child: Container(
                    width: queryData.size.width * 0.2,
                    height: queryData.size.height * 0.092,
                    margin: EdgeInsets.only(right: 10),
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(authPro.userModel!.avatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: AppColors.blackColor.withOpacity(0.3),
                        child: Image.asset(AppImages.cameraIcon),),
                    ),
                  ),
                ):
                Stack(
                  children: [
                    Container(
                      width: queryData.size.width * 0.2,
                      height: queryData.size.height * 0.092,
                      margin: EdgeInsets.only(right: 10),
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(imageFile),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            imageFile=File("");
                            pickedFile=null;
                          });
                        },
                        child: Container(
                          decoration:
                           BoxDecoration(
                            shape:
                            BoxShape.circle,
                            color: AppColors.greyColor,
                          ),
                          padding:
                          EdgeInsets.all(4),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //---Name
                SizedBox(
                  height: queryData.size.height * 0.025,
                ),
                Text(
                  getTranslated(context, 'name_') ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.darkblackColor,
                    12.sp,
                    FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.01,
                ),
                TextFormField(
                  controller: nameControllerProfile,
                  cursorColor: AppColors.mainPurpleColor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      FieldValidator.validateName(nameControllerProfile.text),
                  decoration: AppInputDecoration.circularFieldDecoration(
                    null,
                    'enter_name',
                    null,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.01,
                ),
                Text(
                  getTranslated(context, 'you_can_change') ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.darkGreyColor,
                    12.sp,
                    FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                //---User Name
                Text(
                  getTranslated(context, 'username') ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.darkblackColor,
                    12.sp,
                    FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.01,
                ),
                TextFormField(
                  controller: usernameControllerProfile,
                  cursorColor: AppColors.mainPurpleColor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  // validator: (value) => FieldValidator.validateEmail(usernameControllerProfile.text),
                  decoration: AppInputDecoration.circularFieldDecoration(
                    null,
                    'enter_username',
                    null,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.01,
                ),
                Text(
                  getTranslated(context, 'you_can_change_your_name') ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.darkGreyColor,
                    12.sp,
                    FontWeight.w600,
                  ),
                ),
                options.isNotEmpty ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: queryData.size.height*0.02,
                    ),
                    Text(
                      "Username already taken please choose a unique Username",
                      style: AppTextStyle.ModernEra(
                        AppColors.redColor,
                        12.sp,
                        FontWeight.w400,
                      ),
                    ),
                    Column(
                      children: options.map((option) {
                        return RadioListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text(option,style: AppTextStyle.ModernEra(
                            AppColors.darkGreyColor,
                            14.sp,
                            FontWeight.w600,
                          ),),
                          value: option,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value!;
                              usernameControllerProfile.text=value!;
                            });
                          },
                          activeColor: AppColors.mainPurpleColor, // Set the color of the selected dot
                        );
                      }).toList(),
                    )
                  ]
                ):SizedBox(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        _showDialog(
                            'disable_account',
                            'are_you_sure_you_want_to_disable_account',
                            'cancel',
                                (){
                              Navigator.of(context).pop();
                            },
                            'disable',
                                (){

                            }
                        );
                      },
                      child: Text(getTranslated(context,'disable_account')??"",
                        style: AppTextStyle.ModernEra(
                          AppColors.mainPurpleColor,
                          12.sp,
                          FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        _showDialog(
                            'delete_account',
                            'are_you_sure_you_want_to_delete',
                            'cancel',
                                (){
                              Navigator.of(context).pop();
                            },
                            'delete',
                                ()async{
                                  deleteAccount();
                            }
                        );
                      },
                      child: Text(getTranslated(context,'delete_account')??"",
                        style: AppTextStyle.ModernEra(
                          AppColors.redColor,
                          12.sp,
                          FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.05,
                ),
              ],
            ),
          ),
            if (isLoading)
              LoadingWidget(),
          ]
        ),
      );
    });
  }
  _showDialog(
      String title,String description,
      String btnOneText,
      Function onCancle,
      String btnTwoText,
      Function onTap2,
      ){
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context){
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Text(getTranslated(context, title)??"",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  17.sp,
                  FontWeight.w600,
                ),),
              content: Text(getTranslated(context, description)??"",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  13.sp,
                  FontWeight.w400,
                ),),
              actions: <Widget>[
                TextButton(
                  onPressed: (){
                    onCancle();
                  },
                  child: Text(getTranslated(context, btnOneText)??"",
                    style: AppTextStyle.ModernEra(
                      AppColors.blueColor,
                      17.sp,
                      FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){
                    onTap2();
                  },
                  child: Text(getTranslated(context, btnTwoText)??"",
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
        }
    );
  }
  //===================File Picker===================================
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      pickedFile = result.files.first;
      imageFile = File(result.files.first.path ?? "");
      setState(() {

      });
      // Get.back(result: result);
    } else {
      // User canceled the picker
    }
  }
  //============================================================
  void editProfile()async{
    // print("Post ID is :${commentID}");
    // print("Status is :${status}");
    var token = await Helper.Token();
    setState(() {
      isLoading=true;
    });

    Services.postEditProfile(
        {
          "name":nameControllerProfile.text,
          "username":usernameControllerProfile.text,
        }
        ,pickedFile!,
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
        "/user/update"
    ).then((response){
      print("Response  :${response}");
      final data=response;
      final match=data["success"];
      if(match==true){
        Services.getApi(
            {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${token}',
            },
            '/user'
        ).then((value) {
          setState(() {
            isLoading=false;
          });
          UserModel  userModel =UserModel.fromJson(value);
          var model = Provider.of<AuthVM>(context, listen: false);
          model.userModel=userModel.content.user;
          Helper.ToastFlutter(data["description"]);
          Get.to(HomeView());
        });
      }else
      {
        var errorsMap = response['errors'];
       options.addAll(List<String>.from(response["errors"]));
        setState(() {
          isLoading=false;
        });
        // Helper.ToastFlutter( errorsMap);
      }
    });
  }
  //----------Delete Account-----------------------------------
  void deleteAccount()async{
    setState((){
      isLoading=true;
    });
    var token=await Helper.Token();
    Services.deleteApi(
        '/user/delete-account',
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }
    ).then((data)async{
      print("------{$data}--------");
      final match=data["success"];
      if(match==true){
        setState((){
          isLoading=true;
        });
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Get.offAll(PhoneNumber());
        Helper.ToastFlutter(data["description"]);
      }else{
        Helper.ToastFlutter(data["description"]);
      }
    });
  }
}
