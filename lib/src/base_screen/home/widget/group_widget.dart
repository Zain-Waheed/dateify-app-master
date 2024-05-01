

import 'package:dateify_project/src/base_screen/home/model/group_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';

class GroupWidget extends StatefulWidget {
 DatumGroups datumGroups;
 GroupWidget({Key? key, required this.datumGroups}) : super(key: key);

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      width: queryData.size.width*0.45,
      height: queryData.size.height*0.14,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: AppColors.mainPurpleColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
             topLeft: Radius.circular(10),
             topRight: Radius.circular(10),
            ),
            child: Image.network(
             widget.datumGroups.avatar,
              width:queryData.size.width,
              height:queryData.size.height*0.065,
              fit: BoxFit.fill,),
          ),
          Container(
            width: queryData.size.width,
            padding: const EdgeInsets.symmetric(horizontal: 12)
                +const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.datumGroups.name,
                  style: AppTextStyle.ModernEra(
                    AppColors.whiteColor,
                    16.sp,
                    FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(widget.datumGroups.totalMembers.toString()+"  members",
                  style: AppTextStyle.ModernEra(
                    AppColors.whiteColor,
                    12.sp,
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// SearchGroupWidget(
// onpressed: (){},
// title: 'you_dont_have_any_groups_yet',
// subTitle: 'search_for_a_first_group_and_let_get',
// btnIcon: AppImages.search,
// btnText: 'search_group',),