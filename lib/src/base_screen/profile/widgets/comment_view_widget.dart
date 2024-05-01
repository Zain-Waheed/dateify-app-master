

import 'package:dateify_project/backend/api_request.dart';
import 'package:dateify_project/src/base_screen/home/view/post_view.dart';
import 'package:dateify_project/src/base_screen/profile/model/single_post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import '../../../../utils/helper.dart';
import '../../../auth/view_model/auth_vm.dart';
import '../../home/model/post_model.dart';

class CommentViewWidgt extends StatefulWidget {
  final int postId;
  const CommentViewWidgt({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentViewWidgt> createState() => _CommentViewWidgtState();
}

class _CommentViewWidgtState extends State<CommentViewWidgt> {
  bool isLoading=false;
 late SinglePostModel postItem;
  List<ImagePicP> imagesPicP = [];
  @override
  void initState() {
    fetchPost();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return Consumer<AuthVM>(builder: (context,authPro,_){
    return Scaffold(
      body:Container(
        width: Get.width,
        height: Get.height,
        child: isLoading==true?Center(child: CircularProgressIndicator()):
        PostView(
          model: Datum(
            id:postItem.content.post.id,
            isFlag:postItem.content.post.isFlag,
            isAnonymous:postItem.content.post.isAnonymous,
            isApproved:postItem.content.post.isApproved,
            flagDescription:postItem.content.post.flagDescription,
            flagCount:postItem.content.post.flagCount,
            description:postItem.content.post.description,
            userId:postItem.content.post.userId,
            groupId:postItem.content.post.groupId,
            createdAt:postItem.content.post.createdAt,
            updatedAt:postItem.content.post.updatedAt,
            avatar:postItem.content.post.avatar,
            images:imagesPicP,
            likesCounter:postItem.content.post.likesCounter,
            dislikesCounter:postItem.content.post.dislikesCounter,
            reactionType:postItem.content.post.reactionType,
            commentsCount:postItem.content.post.commentsCount,
            user:User(
                id: authPro.userModel!.id,
                name: authPro.userModel!.name,
                username: authPro.userModel!.username,
                gender: authPro.userModel!.gender,
                dob: authPro.userModel!.dob,
                phone: authPro.userModel!.phone,
                idVerified: authPro.userModel!.idVerified,
                createdAt: authPro.userModel!.createdAt,
                updatedAt: authPro.userModel!.updatedAt,
                firstImage: authPro.userModel!.firstImage,
                avatar: authPro.userModel!.avatar,
                large: authPro.userModel!.large,
                blurredAvatar:
                authPro.userModel!.blurredAvatar),
          ),
        ),
      ),
    );
  });
  }
  void fetchPost()async{
    setState(() {
      isLoading = true;
    });
    var token = await Helper.Token();
    Services.getApi({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
    }, '/posts/post?post_id=${widget.postId}')
        .then((response) {
      final dataResponse = response;
      if (dataResponse["success"] == true) {
        setState(() {
          SinglePostModel singlePostModel =SinglePostModel.fromJson(response);
          postItem=singlePostModel;
        });
        imagesPicP.clear();
        for(int i=0;i<postItem.content.post.images.length;i++){
          imagesPicP.add(
            ImagePicP(
              id: i,
              url: postItem!.content.post.images[i].url,
              order: i,
            ),
          );
        }
        if(mounted){
          setState(() {
            isLoading = false;
          });
        }

      } else {
        Helper.ToastFlutter(dataResponse["description"]);
      }
    });
  }
}
