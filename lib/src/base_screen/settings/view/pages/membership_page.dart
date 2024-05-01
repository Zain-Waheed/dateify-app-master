import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_images.dart';
import '../../../../../resources/text_styles.dart';

class MemberShipPage extends StatefulWidget {
  const MemberShipPage({Key? key}) : super(key: key);

  @override
  State<MemberShipPage> createState() => _MemberShipPageState();
}

class _MemberShipPageState extends State<MemberShipPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          SizedBox(
            height: queryData.size.height*0.4,
          ),
          Text('No Membership Available',
          style: AppTextStyle.ModernEra(
              AppColors.blackColor,
              20.sp,
              FontWeight.w600,
          ),),
          //======================================================
          Spacer(),
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
            height: queryData.size.height*0.07,
          ),
        ],
      ),
    );
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// getTranslated(context, 'current') ?? "",
// style: AppTextStyle.ModernEra(
// AppColors.darkGreyColor,
// 12.sp,
// FontWeight.w400,
// ),
// ),
// SizedBox(
// height: queryData.size.height*0.2,
// ),
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// color: AppColors.whiteColor,
// ),
// child: Column(
// children: [
//
// ],
// ),
// ),
// ],
// ),