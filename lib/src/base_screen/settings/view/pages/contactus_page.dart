import 'dart:io';

import 'package:dateify_project/resources/app_images.dart';
import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/src/base_screen/settings/view/settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../backend/api_request.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/input.decorations.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../utils/helper.dart';
import '../../../../../utils/validation.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../auth/view/widgets/app_button.dart';
import '../../../home/view_model/home_vm.dart';
import '../../view_model/setting_vm.dart';
import '../../widgets/bottom_sheets/contactus_bottomsheet.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  List<File> _imageList = [];
  List<File> _imageList2 = [];
  String? email;
  String? message;
  bool isLoading = false;
  bool _isBothFieldsFilled = false;
  @override
  void initState() {
    super.initState();

    // Listen to the onChanged callback of both fields
    emailController.addListener(_checkIfBothFieldsFilled);
    messageController.addListener(_checkIfBothFieldsFilled);
  }

  void _checkIfBothFieldsFilled() {
    // Update the boolean variable based on whether both fields have non-empty values
    setState(() {
      _isBothFieldsFilled =
          emailController.text.isNotEmpty && messageController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<SettingVM>(builder: (context, settingPro, _) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            leadingWidth: 300,
            backgroundColor: AppColors.whiteColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(5),
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(top: 14.0, left: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      AppImages.arrowback,
                      width: queryData.size.width * 0.08,
                      height: queryData.size.height * 0.06,
                    ),
                  ),
                  Text(
                    getTranslated(context, 'contact_us') ?? "",
                    style: AppTextStyle.ModernEra(
                      AppColors.blackColor,
                      20.sp,
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0.3,
          ),
        ),
        body: Stack(children: [
          Container(
            width: queryData.size.width,
            height: queryData.size.height,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //---User Name
                      Text(
                        getTranslated(context, 'email') ?? "",
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
                        controller: emailController,
                        cursorColor: AppColors.mainPurpleColor,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            FieldValidator.validateEmail(emailController.text),
                        decoration: AppInputDecoration.circularFieldDecoration(
                          null,
                          'enter_your_email',
                          null,
                        ),
                      ),
                      //---Message
                      SizedBox(
                        height: queryData.size.height * 0.02,
                      ),
                      Text(
                        getTranslated(context, 'message') ?? "",
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
                        maxLines: 6,
                        controller: messageController,
                        cursorColor: AppColors.mainPurpleColor,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            FieldValidator.validateDescription(
                                messageController.text),
                        decoration:
                            AppInputDecoration.circularFieldDecStartHint(
                          null,
                          'write_your_message',
                          null,
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.005,
                      ),
                      Text(
                        getTranslated(context, 'max_250_symbols') ?? "",
                        style: AppTextStyle.ModernEra(
                          AppColors.darkGreyColor,
                          12.sp,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                //---ScreenShots
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Text(
                  getTranslated(context, 'screenshots') ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    12.sp,
                    FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.01,
                ),
                Text(
                  "You can add 6 photos",
                  style: AppTextStyle.ModernEra(
                    AppColors.darkGreyColor,
                    12.sp,
                    FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.01,
                ),
                SizedBox(
                  width: queryData.size.width,
                  height: queryData.size.height * 0.35,
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    padding: EdgeInsets.all(8),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.whiteColor,
                          border: Border.all(
                            color: AppColors.greyColor,
                            width: 1,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.plus,
                                    width: queryData.size.width * 0.08,
                                    height: queryData.size.height * 0.06),
                                Text(
                                  getTranslated(context, 'add_photo') ?? "",
                                  style: AppTextStyle.ModernEra(
                                    AppColors.mainPurpleColor,
                                    10.sp,
                                    FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      for (var imageFile in _imageList)
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                imageFile,
                                width: 100, // Set width of each widget
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _removeImage(imageFile),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.01,
                ),
                AppButton(
                    buttonText: 'continue',
                    onpressed: () {
                      // Get.to(VerifyIDView());
                      // if(pickedFile?.path == null){
                      //   Helper.ToastFlutter("Please upload a profile picture");
                      // }
                      // if(formKey.currentState!.validate()&&pickedFile?.path != null)

                      if (formKey.currentState!.validate()) {
                        setState(() {
                          email = emailController.text;
                          message = messageController.text;
                          _imageList2.addAll(_imageList);
                        });
                        requestContactPost();
                      }
                    },
                    width: queryData.size.width * 1,
                    isWhite: !_isBothFieldsFilled),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
              ],
            ),
          ),
          if (isLoading) const LoadingWidget(),
        ]),
      );
    });
  }

  void _pickImage() async {
    final pickedFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (pickedFiles != null) {
      final newImageList = pickedFiles.files
          .take(6 - _imageList.length)
          .map((file) => File(file.path!))
          .toList();

      setState(() {
        _imageList.addAll(newImageList);
      });

      if (pickedFiles.files.length > 6 - _imageList.length) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Warning'),
            content: Text('Only the first 6 images were selected.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _removeImage(File imageFile) {
    setState(() {
      _imageList.remove(imageFile);
    });
  }

  //-----------------------------------------------------------------
//---Contact us--------------------
//===================New Post APi====================================
  void requestContactPost() async {
    var token = await Helper.Token();
    print("******The Token is *****${token}");
    setState(() {
      isLoading = true;
    });

    Services.contactUsPost(
        {
          "email": email,
          "message": message,
        },
        _imageList2,
        "/support/contact-us",
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }).then((response) {
      setState(() {
        isLoading = false;
      });
      Get.bottomSheet(ContactUsBottomsheet(
        onPressed: () {
          Get.back();
        },
      ));
      final data = response;
      final match = data["success"];
      if (match == true) {
        Helper.ToastFlutter(data["description"]);
        print("***********Posted Successfuly****************");
        // Get.to(HomeView());
        // Get.bottomSheet(PostedBottomSheet());
      } else {
        Helper.ToastFlutter(data["message"]);
      }
    });
  }
}
