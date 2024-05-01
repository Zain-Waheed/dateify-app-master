import 'dart:convert';

import 'package:dateify_project/src/base_screen/profile/widgets/Dialog%20Box/leave_group_dialogbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../resources/app_images.dart';
import '../../../../../backend/api_request.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../utils/helper.dart';
import '../../../home/model/group_model.dart';
import '../../../home/widget/profile_group_card.dart';
import '../../../home/widget/search_group_widget.dart';
import 'package:http/http.dart' as http;

class GroupSection extends StatefulWidget {
  const GroupSection({Key? key}) : super(key: key);

  @override
  State<GroupSection> createState() => _GroupSectionState();
}

class _GroupSectionState extends State<GroupSection> {
  //====Group Variables===========
  final groupController = ScrollController();
  List<DatumGroups> groupitems = [];
  bool hasMoreGroups = true;
  int groupPage = 1;
  bool isLoadingGroups = false;
  //==============================
  @override
  void initState() {
    fetchGroups();
    groupController.addListener(() {
      if (groupController.position.maxScrollExtent == groupController.offset) {
        fetchGroups();
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    //--------------------------
    groupController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return ListView.builder(
        controller: groupController,
        padding: const EdgeInsets.all(8),
        itemCount: groupitems.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            //----Group Widgets----------------
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SearchGroupWidget(
                  onpressed: () {},
                  title: 'new_groups_new_experiences',
                  subTitle: 'add_new_group_to_explore',
                  btnIcon: AppImages.plus,
                  btnText: 'add_group',
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          } else {
            //--------Other Items Show After that---------------
            index--;
            if (index < groupitems.length) {
              final item = groupitems[index];
              // return  ListTile(title: Text("${item.id}"));
              return ProfileGroupCard(
                datumGroups: item,
                onpressed: () {
                  // Get.dialog(LeaveGroupDialogBox());
                  // LeaveGroupDialogBox();
                  _showDialog(item);
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: hasMoreGroups
                      ? const CircularProgressIndicator()
                      : const Text('No More data to load'),
                ),
              );
            }
          }
        });
    //   ListView(
    //   children: [
    //     SizedBox(
    //       height: 20,
    //     ),
    //     SearchGroupWidget(
    //       onpressed: () {},
    //       title: 'new_groups_new_experiences',
    //       subTitle: 'add_new_group_to_explore',
    //       btnIcon: AppImages.plus,
    //       btnText: 'add_group',
    //     ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Column(
    //       children:   List.generate(4, (index) {
    //         return  ProfileGroupCard(onpressed: (){
    //           // Get.dialog(LeaveGroupDialogBox());
    //           // LeaveGroupDialogBox();
    //           _showDialog();
    //         },);
    //       }),
    //     ),
    //   ],
    // );
  }

  _showDialog(DatumGroups item) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Text(
                'Leave group ${item.name}?',
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  17.sp,
                  FontWeight.w600,
                ),
              ),
              content: Text(
                'Are you sure you want to leave group ${item.name}? ',
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  13.sp,
                  FontWeight.w400,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancle',
                    style: AppTextStyle.ModernEra(
                      AppColors.blueColor,
                      17.sp,
                      FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    groupitems.remove(item);
                    setState(() {
                      leaveGroup(item);
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Leave',
                    style: AppTextStyle.ModernEra(
                      AppColors.redColor,
                      17.sp,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future fetchGroups() async {
    if (isLoadingGroups) return;
    isLoadingGroups = true;
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Helper.ToastFlutter('No Internet Connection');
      } else {
        final url = Uri.parse(
            'https://api.dateifyapp.com/api/v1/groups?&page=$groupPage');
        var token = await Helper.Token();
        // final url=Uri.parse('http://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
        final response = await http.get(url, headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        });
        if (response.statusCode == 200) {
          GroupModel groupModel =
              GroupModel.fromJson(jsonDecode(response.body));
          final List newItems = groupModel.content.groups.data;
          setState(() {
            if (groupModel.content.groups.nextPageUrl != null) {
              groupPage++;
              isLoadingGroups = false;
            } else {
              groupPage = 1;
              hasMoreGroups = false;
            }
            groupitems.addAll(groupModel.content.groups.data);
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
      print("****** Fetch Group ***eeeeeeeee**${e}");
    }
  }

  void leaveGroup(DatumGroups item) async {
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'group_id': '${item.id}',
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
}
