import 'dart:convert';

import 'package:dateify_project/src/base_screen/settings/model/blocked_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../../backend/api_request.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_images.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../utils/helper.dart';
import 'package:http/http.dart' as http;

class BlockedListPage extends StatefulWidget {
  const BlockedListPage({Key? key}) : super(key: key);

  @override
  State<BlockedListPage> createState() => _BlockedListPageState();
}

class _BlockedListPageState extends State<BlockedListPage> {
  //====Blocked Variables===========
  final blockedController = ScrollController();
  List<DatumUserBlocked> blockeditems = [];
  bool hasMoreBlockedUser = true;
  int blockedPage = 1;
  bool isLoadingUsers = false;
  //==============================
  @override
  void initState() {
    fetchBlockedUsers();
    blockedController.addListener(() {
      if (blockedController.position.maxScrollExtent == blockedController.offset) {
        fetchBlockedUsers();
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    //--------------------------
    blockedController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
            width: queryData.size.width,
            height: queryData.size.height*0.7,
            child: ListView.builder(
              controller: blockedController,
              itemCount: blockeditems.length + 1,
              itemBuilder: (context, index) {
                if (index < blockeditems.length) {
                  final itemPosts = blockeditems[index];
                  // return  ListTile(title: Text("${item.id}"));
                  return Column(
                    children: [
                      ListTile(
                        contentPadding:EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage:
                          NetworkImage(blockeditems[index].avatar),
                          radius: 25,
                        ),
                        title:Row(
                          children: [
                            Text(
                              blockeditems[index].name,
                              style: AppTextStyle.ModernEra(
                                AppColors.darkblackColor,
                                14.sp,
                                FontWeight.w600,
                              ),
                            ),
                            Text(
                              "@",
                              style: AppTextStyle.ModernEra(
                                AppColors.darkGreyColor,
                                12.sp,
                                FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Text(
                                blockeditems[index].username,
                                style: AppTextStyle.ModernEra(
                                  AppColors.darkGreyColor,
                                  12.sp,
                                  FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        subtitle:  Row(
                          children: [
                            Text(
                              'Blocked ',
                              style: AppTextStyle.ModernEra(
                                AppColors.darkGreyColor,
                                12.sp,
                                FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Text(
                                blockeditems[index].blockedAt,
                                style: AppTextStyle.ModernEra(
                                  AppColors.darkGreyColor,
                                  12.sp,
                                  FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        trailing:TextButton(
                          onPressed:(){
                            print('The index is :${index}');
                            unblockUser(blockeditems[index].id);
                            setState(() {
                              blockeditems.removeAt(index);
                            });
                          },
                          child: Text(
                            getTranslated(context, "unblockC") ?? "",
                            style: AppTextStyle.ModernEra(
                              AppColors.mainPurpleColor,
                              14.sp,
                              FontWeight.w500,
                            ),
                          ),
                        ),
                        // Text(blockedUseritems[index].name,
                        //   style: AppTextStyle.ModernEra(
                        //     AppColors.darkblackColor,
                        //     14.sp,
                        //     FontWeight.w600,
                        //   ),
                        // ),
                      ),
                      index==blockeditems.length - 1
                          ? SizedBox()
                          : Divider(
                        color: AppColors.darkGreyColor,
                        height: 5,
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: hasMoreBlockedUser
                          ? const CircularProgressIndicator()
                          : blockeditems.isEmpty?Padding(
                            padding: EdgeInsets.only(top: 250),
                            child: Text(getTranslated(context,'you_have_not_blocked')??"",
                        style: AppTextStyle.ModernEra(
                            AppColors.blackColor,
                            20.sp,
                            FontWeight.w600,
                        ),
                        textAlign:TextAlign.center,
                      ),
                          ):SizedBox(),
                      // Column(
                      //   children: [
                      //     SizedBox(
                      //       height: queryData.size.height*0.4,
                      //     ),
                      //     Text(getTranslated(context,'you_have_not_blocked')??"",
                      //       style: AppTextStyle.ModernEra(
                      //         AppColors.blackColor,
                      //         20.sp,
                      //         FontWeight.w600,
                      //       ),
                      //       textAlign:TextAlign.center,
                      //     ),
                      //     //======================================================
                      //     Spacer(),
                      //     Image.asset(AppImages.logoPurple,
                      //       height:queryData.size.height*0.06,
                      //       width: queryData.size.width*0.2,),
                      //     Text(getTranslated(context,'dateify')??"",
                      //       style: AppTextStyle.ModernEra(
                      //         AppColors.blackColor,
                      //         20.sp,
                      //         FontWeight.w700,
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: queryData.size.height*0.07,
                      //     ),
                      //   ],
                      // ),
                    ),
                  );
                }
              },
            ),
          ),
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

  //---------------------------------------------------------------
  Future fetchBlockedUsers() async {
    if (isLoadingUsers) return;
    isLoadingUsers = true;
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Helper.ToastFlutter('No Internet Connection');
      } else {
        final url = Uri.parse('https://api.dateifyapp.com/api/v1/user/blocked-list?&page=0');
        var token = await Helper.Token();
        // final url=Uri.parse('http://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
        final response = await http.post(url, headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        });
        print("----Blocked List----${response.body}");
        if (response.statusCode == 200) {
          BlockedListModel allMyPostsModel =
          BlockedListModel.fromJson(jsonDecode(response.body));
          final List newItems = allMyPostsModel.content.blockList.data;
          setState(() {
            if (allMyPostsModel.content.blockList.nextPageUrl != null) {
              blockedPage++;
              isLoadingUsers = false;
            } else {
              blockedPage = 1;
              hasMoreBlockedUser = false;
            }
            blockeditems.addAll(allMyPostsModel.content.blockList.data);
          });
        }else if (response.statusCode == 400)
          {
            setState(() {
              hasMoreBlockedUser=false;
            });
          }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print("*****Blocked List API****eeeeeeeee**${e}");
    }
  }
  //-Unblock User--------------------------------------------------

  unblockUser(int userId)async{
    print('---User ID----${userId}');
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'user_id': '${userId}',
        },
        '/user/unblock',
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }).then((data) {
      print("---Unblock user---{$data}--------");
      final match = data["success"];
      if (match == true) {
        Helper.ToastFlutter(data["description"]);
      } else {
        Helper.ToastFlutter(data["description"]);
      }
    });
  }
}
