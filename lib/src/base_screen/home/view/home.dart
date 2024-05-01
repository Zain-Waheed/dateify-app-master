import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/resources/app_images.dart';
import 'package:dateify_project/src/auth/view/widgets/app_button.dart';
import 'package:dateify_project/src/base_screen/home/view/pages/new_post.dart';
import 'package:dateify_project/src/base_screen/home/view_model/home_vm.dart';
import 'package:dateify_project/src/base_screen/profile/view/profile.dart';
import 'package:dateify_project/src/base_screen/home/view/pages/your_groups.dart';
import 'package:dateify_project/src/base_screen/settings/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/text_styles.dart';
import '../../notification/view/notification.dart';
import '../../search/view/search.dart';
import '../widget/dont_post_widget.dart';
import '../widget/group_widget.dart';
import '../widget/post_widget.dart';
import '../widget/search_group_widget.dart';

class HomeView extends StatefulWidget {
  static String route = '/homeView';
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<HomeVM>(builder: (context,homePro,_){
      return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
              backgroundColor:AppColors.mainPurpleColor,
            onPressed: (){
                homePro.postitems.clear();
                Get.to(NewPost());
            },
            child: Image.asset(AppImages.plus,color: AppColors.whiteColor,width: queryData.size.width*0.08,height: queryData.size.height*0.08,),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: AppColors.whiteColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(5),
              ),
            ),
            leading: Padding(
              padding:EdgeInsets.only(top: 14.0,left: 16.0),
              child: Row(
                children: [
                  homePro.pageindex!=0? GestureDetector(
                      onTap: (){
                        homePro.pageindex=0;
                        homePro.update();
                        setState(() {

                        });
                      },
                      child: Image.asset(AppImages.arrowback,width: queryData.size.width*0.07,height: queryData.size.height*0.05,)):SizedBox(),
                  appBarTitle(homePro),
                ],
              ),
            ),
            leadingWidth: 300,
            actions: [
              //=====Notification========
             homePro.pageindex==1||homePro. pageindex==3 ?SizedBox():
             GestureDetector(
                  onTap: () {
                 homePro.pageindex=1;
                 homePro.update();
                    setState(() {

                    });
                  }, child: Image.asset(AppImages.notificationIcon,width: queryData.size.width*0.1,height: queryData.size.height*0.1,)),
              SizedBox(
                width: queryData.size.width * 0.02,
              ),
              //=====Search========
             homePro.pageindex==1||homePro.pageindex==3 ?SizedBox():
             GestureDetector(
                  onTap: () {
                    Get.to(SearchView());
                 // homePro.pageindex=2;
                 //    setState(() {
                 //
                 //    });
                  }, child: Image.asset(AppImages.search,width: queryData.size.width*0.1,height: queryData.size.height*0.1,)),
              SizedBox(
                width: queryData.size.width * 0.02,
              ),
              //=====Profile========
            homePro.pageindex==2?GestureDetector(
                  onTap: () {
                    Get.to(const SettingsView());
                  }, child: Image.asset(AppImages.setting,width: queryData.size.width*0.1,height: queryData.size.height*0.1,)):
            homePro. pageindex==1||homePro. pageindex==2 ?
              const SizedBox():
              GestureDetector(
                  onTap: () {
                 homePro.pageindex=2;
                    setState(() {

                    });
                  }, child: Image.asset(AppImages.profile,width: queryData.size.width*0.1,height: queryData.size.height*0.1,)),
              SizedBox(
                width: queryData.size.width * 0.02,
              ),
            ],
            elevation: 0,
            centerTitle: false,
          ),
        ),
        body: Container(
          color: AppColors.lightGreyColor,
          width: queryData.size.width,
          height: queryData.size.height,
          child: IndexedStack(
            index: homePro.pageindex,
            children: const [
              YourGroupsView(),
              NotificationView(),
              ProfileView(),
            ],
          ),
        ),
      );
    });
  }

  appBarTitle(HomeVM homePro) {
    if(homePro.pageindex==2)
      {
        return Text(
          getTranslated(context, 'profile') ?? "",
          style: AppTextStyle.ModernEra(
            AppColors.blackColor,
            20.sp,
            FontWeight.w700,
          ),
        );
      }else
    if(homePro.pageindex==1)
    {
      return Text(
        getTranslated(context, 'notification') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    } else  if(homePro.pageindex==2)
        {
          return Text(
            getTranslated(context, 'search') ?? "",
            style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              20.sp,
              FontWeight.w700,
            ),
          );
        }else
    {
      return Text(
        getTranslated(context, 'your_groups') ?? "",
        style: AppTextStyle.ModernEra(
          AppColors.blackColor,
          20.sp,
          FontWeight.w700,
        ),
      );
    }
  }
}
