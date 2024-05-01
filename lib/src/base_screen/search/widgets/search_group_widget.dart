
import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/src/base_screen/search/model/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../backend/api_request.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/text_styles.dart';
import '../../../../utils/helper.dart';
import 'bottom_sheets/search_group_join_bottomsheet.dart';

class SearchWidget extends StatefulWidget {
  final  DatumSearch datumGroups;
  SearchWidget({Key? key, required this.datumGroups}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<AuthVM>(builder: (context,authPro,_){
      return Container(
        height: queryData.size.height * 0.14,
        width: queryData.size.width,
        margin: EdgeInsets.symmetric(horizontal: 20)+EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(
              width: 1,
              color: AppColors
                  .greyColor //                   <--- border width here
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor,
              spreadRadius: -1,
              blurRadius: 1,
              offset: Offset(0, 6), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
                height: queryData.size.height * 0.14,
                width: 100,
                margin: EdgeInsets.only(right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.datumGroups.avatar,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
              child: Padding(
                padding:EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.datumGroups.name,
                      style: AppTextStyle.ModernEra(
                        AppColors.darkblackColor,
                        14.sp,
                        FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.datumGroups.totalMembers.toString()+' members',
                      style: AppTextStyle.ModernEra(
                        AppColors.darkGreyColor,
                        12.sp,
                        FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    //--Check if the group is joined or Not----------
                    widget.datumGroups.isMember==true?GestureDetector(
                      onTap: (){
                        leaveGroup(widget.datumGroups.id);
                        setState(() {
                          widget.datumGroups.isMember=!widget.datumGroups.isMember;
                        });
                      },
                      child: Text(getTranslated(context,'leave_group')??"",
                        style: AppTextStyle.ModernEra(
                          AppColors.mainPurpleColor,
                          12.sp,
                          FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ):
                    GestureDetector(
                      onTap: (){
                        joinGroup(widget.datumGroups.id,authPro.userModel!.id);
                        setState(() {
                          widget.datumGroups.isMember=!widget.datumGroups.isMember;
                        });
                        Get.bottomSheet(SearchGroupJoinBottom(groupName: widget.datumGroups.name,));
                      },
                      child: Text(getTranslated(context,'join_group')??"",
                        style: AppTextStyle.ModernEra(
                          AppColors.mainPurpleColor,
                          12.sp,
                          FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  void leaveGroup(int id) async {
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'group_id': '${id}',
        },
        '/groups/leave',
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }).then((data) {
      print("------{$data}--------");
      final match = data["success"];
      if (match == true) {
        Helper.ToastFlutter(data["description"]);
      } else {
        Helper.ToastFlutter(data["description"]);
      }
    });
  }
  //----------------------------------------------------
  void joinGroup(int groupId,int userId) async {
    print("--Group ID  ${groupId}--User ID----${userId}");
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'user_id': '${userId}',
          'group_id': '${groupId}',
        },
        '/groups/add-participant',
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }).then((data) {
      print("------{$data}--------");
      final match = data["success"];
      if (match == true) {
        Helper.ToastFlutter(data["description"]);
      } else {
        Helper.ToastFlutter(data["description"]);
      }
    });
  }
}
