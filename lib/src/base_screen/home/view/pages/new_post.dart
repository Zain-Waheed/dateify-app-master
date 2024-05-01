import 'dart:io';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:dateify_project/localization/shared_pref.dart';
import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/src/base_screen/home/view/home.dart';
import 'package:dateify_project/src/base_screen/home/view_model/home_vm.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../../../backend/api_request.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_images.dart';
import '../../../../../resources/input.decorations.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../utils/helper.dart';
import '../../../../../utils/validation.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../widget/bottomsheets/posted_bottomsheet.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final items = [];
  final groupController = TextEditingController();
  final postDescriptionCon = TextEditingController();
  int groupIndex = 0;
  bool addFlag = false;
  bool anonymous = false;
  final sumUpController = TextEditingController();
  final flagController = TextEditingController();
  bool isLoading = false;
  //-------------------------------------------------------------------------
  List<File> _images = [];

  //-------------------------------------------------------------------------
  //-------------------------------------------------------------------------

  final List<Row> itemflag = [
    Row(
      children: [
        Image.asset(AppImages.redFlag),
      ],
    ),
    Row(
      children: [
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
      ],
    ),
    Row(
      children: [
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
      ],
    ),
    Row(
      children: [
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
      ],
    ),
    Row(
      children: [
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
        Image.asset(AppImages.redFlag),
      ],
    ),
  ];
  Row? selectedValue;
  //-------------------------------------------------------------------------
  int falgCount=0;
  int gindex=0;
//-----------------------------------------------------
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       var model = Provider.of<HomeVM>(context, listen: false);
       for(int i=0;i<model.groupModel!.content.groups.data.length;i++){
         final String groupName=model.groupModel!.content.groups.data[i].name;
         print("Group Name   :"+groupName);
         items.add(groupName);
         setState(() {

         });
       }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<AuthVM>(builder: (context, authPro, _) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.greyColor,
              elevation: 0,
              leadingWidth: 100,
              leading: TextButton(
                onPressed: () {
                  Get.to(HomeView());
                },
                child: Text(
                  getTranslated(context, 'cancel') ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    15.sp,
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              title: Text(
                getTranslated(context, 'new_post') ?? "",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  22.sp,
                  FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      // Get.bottomSheet(GroupSelectionBottomSheet());
                      if(formKey.currentState!.validate()){
                        requestPost();
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
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: AppColors.greyColor,
              child: ListView(
                children: [
                  Column(
                    children: [
                      // SizedBox(
                      //   height: queryData.size.height*0.01,
                      // ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor,
                              spreadRadius: -1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 6), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Form(
                          key:formKey,
                          child: TextFormField(
                            readOnly: true,
                            controller: groupController,
                            cursorColor: AppColors.themeColor,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) => FieldValidator.validateGroup(
                                groupController.text),
                            decoration:
                                AppInputDecoration.circularFieldDecoration(
                              null,
                              'select_group',
                              Image.asset(AppImages.dropdownIcon),
                            ),
                            onTap: () {
                              groupController.text=items[0].toString();
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                        cancelButton: CupertinoActionSheetAction(
                                            child: Text('save'),
                                            onPressed: () {
                                              WidgetsBinding.instance.focusManager
                                                  .primaryFocus
                                                  ?.unfocus();
                                              Navigator.pop(context);
                                            }),
                                        actions: [buildPicker()],
                                      ));
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: queryData.size.width,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(
                              width: 1,
                              color: AppColors
                                  .greyColor //                   <--- border width here
                              ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor,
                              spreadRadius: -1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 6), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: queryData.size.height * 0.01,
                            ),
                            anonymous == false
                                ? ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(authPro.userModel!.avatar),
                                      radius: 25,
                                    ),
                                    title: Text(authPro.userModel!.name,
                                      style: AppTextStyle.ModernEra(
                                        AppColors.darkblackColor,
                                        14.sp,
                                        FontWeight.w600,
                                      ),
                                    ),
                                    // subtitle: Text('Anonymos',
                                    //   style: AppTextStyle.ModernEra(
                                    //     AppColors.darkblackColor,
                                    //     14.sp,
                                    //     FontWeight.w500,
                                    //   ),
                                    // ),
                                  )
                                : ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                NetworkImage(authPro.userModel!.blurredAvatar),
                                radius: 25,
                              ),
                                  title: Text(
                                    'Anonymous',
                                    style: AppTextStyle.ModernEra(
                                      AppColors.darkblackColor,
                                      14.sp,
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                            SizedBox(
                              height: queryData.size.height * 0.01,
                            ),
                            TextFormField(
                              inputFormatters: [
                                // Eveerything is allowed except banned words
                                FilteringTextInputFormatter.deny(
                                    RegExp(Helper.denydWords.join("|"),
                                        caseSensitive: false),
                                    replacementString: '***')
                              ],
                              textAlignVertical: TextAlignVertical.top,
                              controller: postDescriptionCon,
                              cursorColor: AppColors.mainPurpleColor,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              maxLines: 10,
                              // validator: (value) =>
                              //     FieldValidator.validateName(postDescriptionCon.text),
                              decoration: AppInputDecoration
                                  .circularFieldPostDecoration(
                                null,
                                'how_was_you_experience',
                                null,
                              ),
                            ),
                            //==========Grid View=======
                            _images.isNotEmpty
                                ? Container(
                                    width: queryData.size.width,
                                    height: queryData.size.height * 0.15,
                                    child: SingleChildScrollView(
                                      // Wrap GridView inside SingleChildScrollView
                                      scrollDirection: Axis
                                          .horizontal, // Set scroll direction to horizontal
                                      child: Row(
                                        children: [
                                          for (int i = 0;
                                              i < _images.length;
                                              i++)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Stack(
                                                  children: [
                                                    Image.file(
                                                      _images[i],
                                                      width:
                                                          100, // Set width of each widget
                                                      height:
                                                          100, // Set height of each widget
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: InkWell(
                                                        onTap: () =>
                                                            _removeImage(i),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
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
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            //==========================
                            Divider(
                              color: AppColors.darkGreyColor,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  child: Checkbox(
                                    value: addFlag,
                                    activeColor: AppColors.mainPurpleColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        addFlag = value!;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  getTranslated(context, "add_flag") ?? "",
                                  style: AppTextStyle.ModernEra(
                                    AppColors.blackColor,
                                    12.sp,
                                    FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            addFlag == true
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: queryData.size.height * 0.02,
                                        ),
                                        //====================================
                                        //====================================
                                        Container(
                                          width: queryData.size.width,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Row(
                                                children:  [
                                                  Expanded(
                                                    child: Text(
                                                      'Please select a flag',
                                                      style: AppTextStyle.ModernEra(
                                                          AppColors.darkGreyColor,
                                                          14.sp,
                                                          FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              items: itemflag
                                                  .map((item) =>
                                                  DropdownMenuItem<Row>(
                                                    value: item,
                                                    child: item,
                                                  )
                                              ).toList(),
                                              value: selectedValue,
                                              onChanged: (value) {
                                                falgCount=itemflag.indexOf(value!);
                                                print('The Flag Count is ${falgCount}');
                                                setState(() {
                                                  selectedValue = value;
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 50,
                                                width: 160,
                                                padding: const EdgeInsets.only(left: 14, right: 14,top: 14,bottom: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  border: Border.all(
                                                    color: AppColors.greyColor,
                                                  ),
                                                  color: AppColors.whiteColor,
                                                ),
                                              ),
                                              iconStyleData:  IconStyleData(
                                                icon: Image.asset(AppImages.dropdownIcon,width: queryData.size.width*0.06,height: queryData.size.height*0.04),
                                                iconSize: 14,
                                                iconEnabledColor: AppColors.blackColor,
                                                iconDisabledColor: Colors.grey,
                                              ),
                                              dropdownStyleData: DropdownStyleData(
                                                maxHeight: 200,
                                                width: 200,
                                                padding: null,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(14),
                                                  color: AppColors.whiteColor,
                                                ),
                                                elevation: 2,
                                              ),
                                              menuItemStyleData: const MenuItemStyleData(
                                                height: 40,
                                                padding: EdgeInsets.only(left: 14, right: 14,bottom: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   width: queryData.size.width,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(40.0),
                                        //     border: Border.all(
                                        //       color: AppColors.greyColor,
                                        //       width: 1.0,
                                        //     ),
                                        //   ),
                                        //   padding: EdgeInsets.only(left: 20),
                                        //   child: DropdownButton<String>(
                                        //
                                        //       underline: Container(),
                                        //       alignment: AlignmentDirectional
                                        //           .bottomCenter,
                                        //       elevation: 0,
                                        //       value: _selectedItem,
                                        //       items: _items.map((item) {
                                        //         return DropdownMenuItem<String>(
                                        //           value: item['value'],
                                        //           child: Row(
                                        //             children: <Widget>[
                                        //               Icon(item['icon']),
                                        //               SizedBox(width: 170.0),
                                        //               Text(item['value']),
                                        //             ],
                                        //           ),
                                        //         );
                                        //       }).toList(),
                                        //       onChanged: (newValue) {
                                        //         setState(() {
                                        //           _selectedItem = newValue;
                                        //         });
                                        //       },
                                        //       selectedItemBuilder:
                                        //           (BuildContext context) {
                                        //         return _items
                                        //             .map<Widget>((item) {
                                        //           return Row(
                                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //             children: <Widget>[
                                        //               Icon(item['icon']),
                                        //               SizedBox(width: 10.0),
                                        //             ],
                                        //           );
                                        //         }).toList();
                                        //       }),
                                        // ),
                                        // Container(
                                        //   width: queryData.size.width,
                                        //   child: CoolDropdown(
                                        //     isMarquee:true,
                                        //     dropdownList: fruitDropdownItems,
                                        //     controller:listDropdownController,
                                        //     onChange: (value) {
                                        //
                                        //     },
                                        //     resultOptions: const ResultOptions(
                                        //       width: 70,
                                        //       render: ResultRender.icon,
                                        //       icon: SizedBox(
                                        //         width: 10,
                                        //         height: 10,
                                        //         child: CustomPaint(
                                        //           painter: DropdownArrowPainter(color: Colors.green),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     dropdownOptions:  DropdownOptions(
                                        //       width: 300,
                                        //     ),
                                        //     dropdownItemOptions:  DropdownItemOptions(
                                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //       selectedBoxDecoration: BoxDecoration(
                                        //         color: AppColors.mainPurpleColor.withOpacity(0.3),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        //====================================
                                        //====================================
                                        SizedBox(
                                          height: queryData.size.height * 0.01,
                                        ),
                                        TextFormField(
                                          controller: sumUpController,
                                          cursorColor:
                                              AppColors.mainPurpleColor,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) =>
                                              FieldValidator.validateName(
                                                  sumUpController.text),
                                          decoration: AppInputDecoration
                                              .circularFieldDecSum(
                                            null,
                                            'sum_up',
                                            null,
                                          ),
                                        ),
                                        SizedBox(
                                          height: queryData.size.height * 0.01,
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            Divider(
                              color: AppColors.darkGreyColor,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: Checkbox(
                                    value: anonymous,
                                    activeColor: AppColors.mainPurpleColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        anonymous = value!;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  getTranslated(context, 'post_anonymously') ??
                                      "",
                                  style: AppTextStyle.ModernEra(
                                    AppColors.blackColor,
                                    12.sp,
                                    FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: _pickImages,
                                  icon: Image.asset(AppImages.imageIcon,width: queryData.size.width*0.06,height: queryData.size.height*0.04),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) const LoadingWidget(),
        ],
      );
    });
  }

  //========Pick Group=-======================================
  Widget buildPicker() => SizedBox(
        height: 150,
        child: CupertinoPicker(
          itemExtent: 50,
          onSelectedItemChanged: (int value) {
            setState(() {
              groupIndex = value;
              groupController.text = items[groupIndex];
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
  //========Pick Images=======================================
  Future<void> _pickImages() async {
    final pickedFiles = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles.paths.map((path) => File(path!)));
      });
    }
  }

  //========Remove Images======================================
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

//===================New Post APi====================================
  void requestPost() async {
    var model = Provider.of<HomeVM>(context, listen: false);
    for(int i=0;i<model.groupModel!.content.groups.data.length;i++){
      final String groupName=model.groupModel!.content.groups.data[i].name;
      print("Group Name   :"+groupName);
      if(groupName==groupController.text){
        gindex=model.groupModel!.content.groups.data[i].id;
        print("Group Founded ${gindex}");
      }else{
        print("Group does not Founded");
      }
    }
   //-----------------------------------------------------------------
    // int groupIndex=items.indexOf(groupController.text);
    // groupIndex++;
    print("******The Group index is *****${groupIndex}");
    print("******The Images are*****${_images}");
    var token=await Helper.Token();
    int flagC=falgCount+1;
    print("******The Token is *****${token}");
    setState(() {
      isLoading = true;
    });

    Services.newPost({
      "is_flag": addFlag == true ? "1" : "0",
      "is_anonymous": anonymous == true ? "1" : "0",
      "flag_description": addFlag==true?sumUpController.text:"",
      "flag_count": "${flagC}",
      "description": postDescriptionCon.text,
      "group_id": "${gindex}",
    },
        _images, "/posts/create",
    {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
    }
    )
        .then((response) {
      setState(() {
        isLoading = false;
      });
      final data = response;
      final match = data["success"];
      if (match == true) {
        Helper.ToastFlutter(data["description"]);
        print("***********Posted Successfuly****************");
        Get.to(HomeView());
        Get.bottomSheet(PostedBottomSheet());
      } else {
        Helper.ToastFlutter(data["message"]);
        // var errorsMap = response['errors'];
        // var errorMessageString = '';
        // errorsMap.forEach((key, value) {
        //   // Get the error message(s) for this key
        //   var errorMessages = value as List<dynamic>;
        //
        //   // Concatenate the key and each error message into a formatted string
        //   var formattedErrors = errorMessages
        //       .map((errorMessage) => ' $errorMessage')
        //       .join('\n');
        //
        //   // Append the formatted errors to the error message string
        //   errorMessageString += formattedErrors + '\n';
        // });
        // Helper.ToastFlutter( errorMessageString);
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
