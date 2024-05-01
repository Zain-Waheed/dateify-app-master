import 'package:dateify_project/backend/api_request.dart';
import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/resources/app_colors.dart';
import 'package:dateify_project/resources/app_images.dart';
import 'package:dateify_project/resources/text_styles.dart';
import 'package:dateify_project/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../models/user_model.dart' as user;
import '../../auth/view_model/auth_vm.dart';
import '../../base_screen/home/view/home.dart';
import '../../base_screen/home/view_model/home_vm.dart';
import 'onboarding.dart';


class SplashScreen extends StatefulWidget {
  static String route = '/splashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),()async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? isLogin = prefs.getString("isLogin");
      var token=await Helper.Token();
      if(isLogin=='true'){
        Services.getApi(
          {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          },
          '/user'
        ).then((value) {
         user.UserModel  userModel =user.UserModel.fromJson(value);
        var model = Provider.of<AuthVM>(context, listen: false);
        model.userModel=userModel.content.user;
          Get.to(HomeView());
        });
      }else
      {
        Get.offAll(OnBoardingView());
      }
    },
    );
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<AuthVM>(builder:(context,landingPro,_){
      return  Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundImg),
              fit: BoxFit.cover,
            ),
          ),
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logoIcon,width: queryData.size.width*0.5,height: queryData.size.height*0.2,),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height*0.01,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height,
                //     color: AppColors.greenColor,
                //   ),
                // ),
                Text(getTranslated(context,'dateify')??"",
                  style: AppTextStyle.ModernEra(
                    AppColors.whiteColor,
                    50.sp,
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
