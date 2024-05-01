//
//
//
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:todo/main.dart';
// import 'package:todo/resources/app_colors.dart';
// import 'package:todo/resources/app_images.dart';
// import 'package:todo/resources/text_styles.dart';
// import 'package:todo/src/base_screen/base_vm.dart';
// import 'package:todo/src/base_screen/home/view/popular_videos.dart';
// import 'package:todo/src/base_screen/profile/view/edit_profile.dart';
// import 'package:todo/src/base_screen/profile/view/profile_screen.dart';
// import 'package:todo/src/base_screen/settings/about_us.dart';
// import 'package:todo/src/base_screen/settings/privacy_policy.dart';
// import 'package:todo/src/base_screen/settings/setting_detail_screen.dart';
// import 'package:todo/src/base_screen/settings/settings_screen.dart';
//
// import '../../widgets/top_bar.dart';
// import 'category/model/category_one.dart';
// import 'favorite/view/favorite_screen.dart';
// import 'home/view/all_videos.dart';
// import 'home/view/home_screen.dart';
// import 'home/view/new_videos.dart';
// import 'home/view/premium_package.dart';
// import 'home/view/search_all_videos.dart';
// import 'home/view/video_details.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Consumer<BaseVM>(builder: (context,dashPro,_){
//       return GestureDetector(
//         onTap: (){
//           dashPro.setFocus();
//         },
//         child: Scaffold(
//           extendBody: true,
//           backgroundColor: AppColors.backgroundColor,
//           bottomNavigationBar: BottomNavigationBar(
//             backgroundColor: AppColors.whiteColor,
//             currentIndex: dashPro.baseCurrentPage,
//             onTap: (index){
//               setState(() {
//                 dashPro.updatePage(index);
//                 dashPro.basePageViewController?.jumpToPage(index);
//                 dashPro.update();
//               });
//             },
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                   icon: Padding(
//                     padding: EdgeInsets.only(top: Get.height*0.02),
//                     child: Image.asset(AppImages.homeIcon,scale:3.sp),
//                   ),
//                   activeIcon: Padding(
//                     padding: EdgeInsets.only(top: Get.height*0.02),
//                     child: Image.asset(AppImages.homeIcon,scale:3.sp,color: AppColors.orangeColor,),
//                   ),
//                   label: ""
//               ),
//               BottomNavigationBarItem(
//                   icon: Padding(
//                     padding: EdgeInsets.only(top: Get.height*0.02),
//                     child: Image.asset(AppImages.favoriteIcon,scale:3.sp,),
//                   ),
//                   activeIcon: Padding(
//                     padding: EdgeInsets.only(top: Get.height*0.02),
//                     child: Image.asset(AppImages.favoriteIcon,scale:3.sp,color: AppColors.orangeColor,),
//                   ),
//                   label: ""
//               ),
//               BottomNavigationBarItem(
//                   icon: Padding(
//                     padding: EdgeInsets.only(top: Get.height*0.02),
//                     child: Image.asset(AppImages.profileIcon,scale:3.sp,),
//                   ),
//                   activeIcon: Padding(
//                     padding: EdgeInsets.only(top: Get.height*0.02),
//                     child: Image.asset(AppImages.profileIcon,scale:3.sp,color: AppColors.orangeColor,),
//                   ),
//                   label: ""
//               ),
//
//             ],
//           ),
//           body: PageView(
//             controller: dashPro.basePageViewController,
//             physics: NeverScrollableScrollPhysics(),
//             children: [
//               HomePage(),
//               FavoriteScreen(),
//               ProfileScreen(),
//               AllVideos(),
//               NewVideos(),
//               PopularVideos(),
//               VideoDetails(),
//               PremiumPackage(),
//               EditProfileScreen(),
//               SettingsScreen(),
//               SearchAllVideosScreen(),
//               SettingDetailScreen(),
//               PrivacyPolicy(),
//               AboutUS(),
//               OneCategoryScreen(),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
//
//
//
