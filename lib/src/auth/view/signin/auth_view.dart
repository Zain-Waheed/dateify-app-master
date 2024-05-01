// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
// import 'package:todo/main.dart';
// import 'package:todo/resources/input.decorations.dart';
// import 'package:todo/src/auth/view/singup_screen.dart';
// import 'package:todo/src/base_screen/base_view.dart';
//
// import '../../../localization/app_localization.dart';
// import '../../../resources/app_colors.dart';
// import '../../../resources/app_images.dart';
// import '../../../resources/text_styles.dart';
// import '../../../utils/validation.dart';
// import '../../../widgets/top_bar.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final formkey = GlobalKey<FormState>();
//
//   var email = " ";
//   var password = " ";
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   Future Signin() async {
//     try {
//       log("**********hamza rana**************");
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       log(userCredential.user!.uid.toString() + "**********hamza");
//
//       // var  baseVm=Provider.of<BaseVM>(context,listen: false);
//       // baseVm.userID=userCredential.user!.uid.toString();
//       // baseVm.update();
//       await StoreUser(userCredential.user!.uid.toString());
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: AppColors.themeColor,
//           content: Text(
//             'Login Successful',
//             style: AppTextStyle.dosis(
//               AppColors.whiteColor,
//               20,
//               FontWeight.w800,
//             ),
//           ),
//         ),
//       );
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('login', true);
//       Get.offAll(HomeScreen());
//     } on FirebaseAuthException catch (error) {
//       print('Failed with error code: ${error.code}');
//       print('***************${error.message}***********');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: AppColors.themeColor,
//           content: Text(
//             '${error.message}',
//             style: AppTextStyle.dosis(
//               AppColors.whiteColor,
//               20,
//               FontWeight.w800,
//             ),
//           ),
//         ),
//       );
//     }
//   }
//
//   Future StoreUser(String userId) async {
//     var collection = FirebaseFirestore.instance.collection('Users');
//     var docSnapshot = await collection.doc(userId).get();
//     if (docSnapshot.exists) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       Map<String, dynamic>? data = docSnapshot.data();
//       var value = data?['Email'];
//       log("********The Name  of Got user is***************** " +
//           value); // <-- The value you want to retrieve.
//       bool result = await prefs.setString('user', jsonEncode(data));
//       log("********User detail Saved in Shared Pref Successfully exist*********" +
//           result.toString());
//     } else {
//       log("********User detail does not exist*********");
//     }
//
//     @override
//     void dispose() {
//       emailController.dispose();
//       passwordController.dispose();
//       super.dispose();
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       return GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(new FocusNode());
//         },
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(Get.height * 0.1),
//             child: TopBar(),
//           ),
//           body: Container(
//             width: Get.width,
//             height: Get.height,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(AppImages.loginBg),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       getTranslated(context, 'kstyles') ?? "",
//                       style: AppTextStyle.Jalnan(
//                         AppColors.appNameColor,
//                         40.sp,
//                         FontWeight.w800,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       getTranslated(context, 'kids') ?? "",
//                       style: AppTextStyle.Jalnan(
//                         AppColors.appNameColor,
//                         40.sp,
//                         FontWeight.w800,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: Get.height * 0.06,
//                     ),
//                     Form(
//                       key: formkey,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.darkYellowColor,
//                                   spreadRadius: -1,
//                                   blurRadius: 1,
//                                   offset: Offset(
//                                       0, 6), // changes position of shadow
//                                 ),
//                               ],
//                             ),
//                             child: TextFormField(
//                               controller: emailController,
//                               cursorColor: AppColors.themeColor,
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               keyboardType: TextInputType.emailAddress,
//                               textInputAction: TextInputAction.next,
//                               validator: (value) =>
//                                   FieldValidator.validateEmail(
//                                       emailController.text),
//                               decoration:
//                                   AppInputDecoration.circularFieldDecoration(
//                                 null,
//                                 'username',
//                                 null,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.02,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.darkYellowColor,
//                                   spreadRadius: -1,
//                                   blurRadius: 1,
//                                   offset: Offset(
//                                       0, 6), // changes position of shadow
//                                 ),
//                               ],
//                             ),
//                             child: TextFormField(
//                               controller: passwordController,
//                               cursorColor: AppColors.themeColor,
//                               obscureText: true,
//                               keyboardType: TextInputType.emailAddress,
//                               textInputAction: TextInputAction.go,
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               validator: (value) =>
//                                   FieldValidator.validatePasswordSignup(
//                                       passwordController.text),
//                               decoration:
//                                   AppInputDecoration.circularFieldDecoration(
//                                 null,
//                                 'password',
//                                 null,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: Get.height * 0.001,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             getTranslated(context, 'forgot_password') ?? "",
//                             style: AppTextStyle.dosis(
//                               AppColors.brownColor,
//                               14.sp,
//                               FontWeight.w800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: Get.height * 0.02,
//                     ),
//                     Stack(
//                       children: [
//                         Container(
//                           alignment: Alignment.bottomCenter,
//                           width: Get.width * 0.9,
//                           height: Get.height * 0.07,
//                           decoration: BoxDecoration(
//                               color: AppColors.brownColor,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(30))),
//                         ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             primary: AppColors.lightYellowColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50.0),
//                             ),
//                           ),
//                           onPressed: () async {
//                             if (formkey.currentState!.validate()) {
//                               setState(() {
//                                 email = emailController.text;
//                                 password = passwordController.text;
//                               });
//                               // Signin();
//                               final prefs =
//                                   await SharedPreferences.getInstance();
//                               await prefs.setBool('login', true);
//                               Signin();
//                               // Get.offAll(HomeScreen());
//                             }
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 top: Get.height * 0.01,
//                                 bottom: Get.height * 0.01),
//                             child: Center(
//                               child: Text(getTranslated(context, "login") ?? "",
//                                   style: AppTextStyle.dosis(
//                                     AppColors.brownColor,
//                                     22.sp,
//                                     FontWeight.w800,
//                                   )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: Get.height * 0.02,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           getTranslated(context, "dont_have_account_yet?") ??
//                               "",
//                           style: AppTextStyle.dosis(
//                             AppColors.brownColor,
//                             12.sp,
//                             FontWeight.w800,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Get.to(SingUpScreen());
//                           },
//                           child: Text(
//                             getTranslated(context, 'register_here') ?? "",
//                             style: AppTextStyle.dosis(
//                               AppColors.blueColor,
//                               12.sp,
//                               FontWeight.w800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).requestFocus(new FocusNode());
//       },
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(Get.height * 0.1),
//           child: TopBar(),
//         ),
//         body: Container(
//           width: Get.width,
//           height: Get.height,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(AppImages.loginBg),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: Get.height * 0.12,
//                   ),
//                   Text(
//                     getTranslated(context, 'kstyles') ?? "",
//                     style: AppTextStyle.Jalnan(
//                       AppColors.appNameColor,
//                       40.sp,
//                       FontWeight.w400,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     getTranslated(context, 'kids') ?? "",
//                     style: AppTextStyle.Jalnan(
//                       AppColors.appNameColor,
//                       40.sp,
//                       FontWeight.w400,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.06,
//                   ),
//                   Form(
//                     key: formkey,
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     child: Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AppColors.darkYellowColor,
//                                 spreadRadius: -1,
//                                 blurRadius: 1,
//                                 offset:
//                                     Offset(0, 6), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: TextFormField(
//                             controller: emailController,
//                             cursorColor: AppColors.themeColor,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             keyboardType: TextInputType.emailAddress,
//                             textInputAction: TextInputAction.next,
//                             // validator: (value)=>FieldValidator.validateEmail(emailController.text),
//                             decoration:
//                                 AppInputDecoration.circularFieldDecoration(
//                               null,
//                               'username',
//                               null,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.02,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AppColors.darkYellowColor,
//                                 spreadRadius: -1,
//                                 blurRadius: 1,
//                                 offset:
//                                     Offset(0, 6), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: TextFormField(
//                             controller: passwordController,
//                             cursorColor: AppColors.themeColor,
//                             obscureText: true,
//                             keyboardType: TextInputType.emailAddress,
//                             textInputAction: TextInputAction.go,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             // validator: (value)=>FieldValidator.validatePasswordSignup(passwordController.text),
//                             decoration:
//                                 AppInputDecoration.circularFieldDecoration(
//                               null,
//                               'password',
//                               null,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.001,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           getTranslated(context, 'forgot_password') ?? "",
//                           style: AppTextStyle.dosis(
//                             AppColors.brownColor,
//                             14.sp,
//                             FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.02,
//                   ),
//                   Stack(
//                     children: [
//                       Container(
//                         alignment: Alignment.bottomCenter,
//                         width: Get.width * 0.9,
//                         height: Get.height * 0.07,
//                         decoration: BoxDecoration(
//                             color: AppColors.brownColor,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(30))),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: AppColors.lightYellowColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                         ),
//                         onPressed: () async {
//                           if (formkey.currentState!.validate()) {
//                             setState(() {
//                               email = emailController.text;
//                               password = passwordController.text;
//                             });
//                             // Signin();
//                             Signin();
//                             // Get.offAll(HomeScreen());
//                           }
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               top: Get.height * 0.01,
//                               bottom: Get.height * 0.01),
//                           child: Center(
//                             child: Text(getTranslated(context, "login") ?? "",
//                                 style: AppTextStyle.dosis(
//                                   AppColors.brownColor,
//                                   22.sp,
//                                   FontWeight.w800,
//                                 )),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         getTranslated(context, "dont_have_account_yet?") ?? "",
//                         style: AppTextStyle.dosis(
//                           AppColors.brownColor,
//                           12.sp,
//                           FontWeight.w800,
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Get.to(SingUpScreen());
//                         },
//                         child: Text(
//                           getTranslated(context, 'register_here') ?? "",
//                           style: AppTextStyle.dosis(
//                             AppColors.blueColor,
//                             12.sp,
//                             FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
