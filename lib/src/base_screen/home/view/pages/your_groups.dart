import 'dart:convert';
import 'package:dateify_project/src/base_screen/home/view_model/home_vm.dart';
import 'package:dateify_project/src/base_screen/home/widget/dont_post_widget.dart';
import 'package:dateify_project/src/base_screen/home/widget/no_groups_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../../backend/api_request.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../utils/helper.dart';
import '../../model/group_model.dart';
import '../../model/post_model.dart';
import '../../widget/group_widget.dart';
import '../../widget/post_widget.dart';
import 'package:http/http.dart' as http;

import '../post_view.dart';

class YourGroupsView extends StatefulWidget {
  const YourGroupsView({Key? key}) : super(key: key);

  @override
  State<YourGroupsView> createState() => _YourGroupsViewState();
}

class _YourGroupsViewState extends State<YourGroupsView> {
  //====Posts Variables==========
  final postController = ScrollController();
  bool hasMorePosts = true;
  int postPage = 1;
  bool isLoadingPosts = false;
  //==============================
  //====Group Variables===========
  final groupController = ScrollController();
  List<DatumGroups> groupitems = [];
  bool hasMoreGroups = true;
  int groupPage = 1;
  bool isLoadingGroups = false;
  //==============================
  @override
  void initState() {
    //==========================
    fetchPosts();
    postController.addListener(() {
      if (postController.position.maxScrollExtent == postController.offset) {
        fetchPosts();
      }
    });
    //======Groups================
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
    postController.dispose();
    //--------------------------
    groupController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future fetchPosts() async {
    if (isLoadingPosts) return;
    isLoadingPosts = true;
    // try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Helper.ToastFlutter('No Internet Connection');
      } else {
        final url = Uri.parse(
            'https://api.dateifyapp.com/api/v1/posts?&page=$postPage');
        var token = await Helper.Token();
        print("Token-------${token}");
        print("PostPage-------${postPage}");
        // final url=Uri.parse('http://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
        final response = await http.get(url,
            headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        });
        if (response.statusCode == 200) {
          Welcome welcome = Welcome.fromJson(jsonDecode(response.body));
          setState(() {
            if (welcome.content.posts.nextPageUrl != null) {
              postPage++;
              isLoadingPosts = false;
            } else {
              postPage = 1;
              hasMorePosts = false;
            }
            // print("------Post Items length-----${postitems.length}");
            var homeVm = Provider.of<HomeVM>(context, listen: false);
            homeVm.postitems.addAll(welcome.content.posts.data);
          });
        }
      }
    // } catch (e) {
    //   Fluttertoast.showToast(
    //       msg: e.toString(),
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       fontSize: 16.0);
    //   print("*********eeeeeeeee Fetch Post API **${e}");
    // }
  }

  Future refresh() async {
    var homeVm = Provider.of<HomeVM>(context, listen: false);
    setState(() {
      isLoadingPosts = false;
      hasMorePosts = true;
      postPage = 0;
      homeVm.postitems.clear();
    });
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<HomeVM>(builder: (context,homePro,_){
      return Container(
        color: AppColors.lightGreyColor,
        width: queryData.size.width,
        height: queryData.size.height,
        child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
              controller: postController,
              padding: const EdgeInsets.all(8),
              itemCount:homePro.postitems.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  //----Group Widgets----------------
                  return  groupitems.isEmpty?SizedBox():
                  Column(
                    children: [
                      Container(
                        height: queryData.size.height * 0.18,
                        width: queryData.size.width,
                        color: AppColors.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 15) +
                            const EdgeInsets.only(left: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                            List.generate(groupitems.length + 1, (index) {
                              if (index < groupitems.length) {
                                final item = groupitems[index];
                                return GroupWidget(datumGroups: item);
                              } else {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 30),
                                  child: Center(
                                    child: hasMoreGroups
                                        ? const CircularProgressIndicator()
                                        : const Text('No More Groups'),
                                  ),
                                );
                              }
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.02,
                      ),
                    ],
                  );
                }
                else {
                  //--------Other Items Show After that---------------
                  index--;
                  if (index <homePro.postitems.length) {
                    final item =homePro.postitems[index];
                    // return  ListTile(title: Text("${item.id}"));
                    return GestureDetector(
                      onTap: (){
                        Get.to(PostView(model: item,));
                      },
                      child: PostWidget(
                        model: item,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: hasMorePosts
                            ? const CircularProgressIndicator()
                            :homePro.postitems.isEmpty?
                        //--When you dont have any groups
                        groupitems.isEmpty?
                        NoGroupsWidget():
                        DontPostWidget(): Text('No More data to load'),
                      ),
                    );
                  }
                }
              }),
        ),
      );
    },);
  }

  Future fetchGroups() async {
    if (isLoadingGroups) return;
    isLoadingGroups = true;
    // try {
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
          var model = Provider.of<HomeVM>(context, listen: false);
          model.groupModel=groupModel;
          model.update();
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
    // } catch (e) {
    //   Fluttertoast.showToast(
    //       msg: e.toString(),
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       fontSize: 16.0);
    //   print("*********eeeeeeeee Fetch Group API **${e}");
    // }
  }

}

// bool isLoading = false;
// Welcome? model;
// @override
// void initState() {
//   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     isLoading=true;
//     Services.getPosts(
//         "/posts/list?group_id=2"
//     ).then((value){
//       setState(() {
//         isLoading=false;
//       });
//       model=value;
//     });
//   });
//   // TODO: implement initState
//   super.initState();
// }
