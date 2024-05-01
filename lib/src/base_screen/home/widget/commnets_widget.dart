import 'package:dateify_project/src/base_screen/home/view_model/home_vm.dart';
import 'package:dateify_project/src/base_screen/home/widget/ReplyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../backend/api_request.dart';
import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/input.decorations.dart';
import '../../../../resources/text_styles.dart';
import '../../../../utils/helper.dart';
import '../../../auth/view_model/auth_vm.dart';
import '../model/comment_model.dart';
import '../view/pages/picture_view.dart';

class CommentsWidget extends StatefulWidget {
  final Comment commnetModel;
  CommentsWidget({Key? key, required this.commnetModel}) : super(key: key);

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String _selectedOption = 'Option 1';
  //=================
  bool _isLiked = false;
  int _likesCount = 0;
  //=================
  bool _disLiked = false;
  int _dislikeCount = 0;
  //---------------------------------------------------------------
  //---------------------------------------------------------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("reaction Type    :${widget.commnetModel.reactionType}");
      if (widget.commnetModel.reactionType == "dislike") {
        setState(() {
          _disLiked = true;
        });
      } else if (widget.commnetModel.reactionType == "like") {
        setState(() {
          _isLiked = true;
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer2<HomeVM, AuthVM>(builder: (context, homeVM, authPro, _) {
      return Column(
        children: [
          Container(
            width: queryData.size.width,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslated(context, 'comments') ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.darkGreyColor,
                    12.sp,
                    FontWeight.w400,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: widget.commnetModel.isAnonymous == 0
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.commnetModel.user.avatar),
                          radius: 25,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.commnetModel.user.blurredAvatar),
                          radius: 25,
                        ),
                  title: widget.commnetModel.isAnonymous == 0
                      ? Row(
                          children: [
                            Text(
                              widget.commnetModel.user.name,
                              style: AppTextStyle.ModernEra(
                                AppColors.darkblackColor,
                                14.sp,
                                FontWeight.w500,
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
                                widget.commnetModel.user.username,
                                style: AppTextStyle.ModernEra(
                                  AppColors.darkGreyColor,
                                  12.sp,
                                  FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Anonymous',
                          style: AppTextStyle.ModernEra(
                            AppColors.darkblackColor,
                            12.sp,
                            FontWeight.w600,
                          ),
                        ),
                  subtitle: Text(
                    widget.commnetModel.createdAt,
                    style: AppTextStyle.ModernEra(
                      AppColors.darkGreyColor,
                      12.sp,
                      FontWeight.w500,
                    ),
                  ),
                  // trailing: tralingPopups(queryData, authPro, homeVM),
                  trailing: authPro.userModel!.id!=widget.commnetModel.userId?
                  PopupMenuButton<String>(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    icon: Image.asset(AppImages.moreIcon,
                        width: queryData.size.width * 0.06,
                        height: queryData.size.height * 0.04),
                    color: AppColors.dropDownColor,
                    padding: EdgeInsets.zero,
                    onSelected: (String value) {
                      setState(() {});
                      print("*****The Selected VAlue is ${value}");
                      if (value == 'Option 1') {
                        _showDialog(
                            'Block @${widget.commnetModel.user.username}',
                            '@${widget.commnetModel.user.username} will no longer be able to view  your post and you will not be able to view posts from @monika',
                            'cancel',
                            () {
                              Navigator.of(context).pop();
                            },
                            'block',
                            () {
                              blockUser(widget.commnetModel.user.id);
                              Navigator.of(context).pop();
                            });
                      } else {
                        _showDialog(
                            'Report comment from @${widget.commnetModel.user.username}',
                            'Comment from @${widget.commnetModel.user.username} reported',
                            'cancel',
                            () {
                              Navigator.of(context).pop();
                            },
                            'delete',
                            () {
                              deleteCommemt(widget.commnetModel.id);
                              Navigator.of(context).pop();
                            });
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                          value: 'Option 1',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: queryData.size.width * 0.55,
                                child: Text(
                                  'Block @${widget.commnetModel.user.username}',
                                  style: AppTextStyle.ModernEra(
                                      AppColors.blackColor,
                                      14.sp,
                                      FontWeight.w600),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Image.asset(AppImages.blockBlack,
                                  width: queryData.size.width * 0.06,
                                  height: queryData.size.height * 0.04),
                            ],
                          )),
                      PopupMenuItem<String>(
                        value: 'Option 2',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: queryData.size.width * 0.5,
                              child: Text(
                                'Report comment from @${widget.commnetModel.user.username}',
                                style: AppTextStyle.ModernEra(
                                    AppColors.blackColor,
                                    14.sp,
                                    FontWeight.w600),
                              ),
                            ),
                            Image.asset(AppImages.flag,
                                width: queryData.size.width * 0.06,
                                height: queryData.size.height * 0.04),
                          ],
                        ),
                      ),
                    ],
                  ):SizedBox(),
                ),
                Text(
                  widget.commnetModel.body ?? "",
                  style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    12.sp,
                    FontWeight.w500,
                  ),
                ),
                //=======================================================================
                widget.commnetModel.images.isNotEmpty
                    ? widget.commnetModel.images.length > 1
                        ?
                        //----Show Multiples Images---------
                        Container(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.5,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: StaggeredGridView.countBuilder(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              itemCount: widget.commnetModel.images.length >= 4
                                  ? 4
                                  : widget.commnetModel.images.length,
                              itemBuilder: (BuildContext context, int index) {
                                int maxImages = 4;
                                int numImages =
                                    widget.commnetModel.images.length;
                                // Check how many more images are left
                                int remaining = numImages - maxImages;
                                // String imageUrl =
                                //     widget.commnetModel.images[index].url;
                                if (index == 0) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        PictureView(
                                          commentModel: widget.commnetModel,
                                          commentImage: true,
                                          initialPage: index,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blackColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            widget.commnetModel.images[0].url !=
                                                    null
                                                ? Image.network(
                                                    widget.commnetModel
                                                        .images[0].url!,
                                                    fit: BoxFit.cover)
                                                : Image.file(
                                                    widget.commnetModel
                                                        .images[0].filePath!,
                                                    fit: BoxFit.cover),
                                      ),
                                    ),
                                  );
                                } else {
                                  print(
                                      "---index:${index}----imageURL:${widget.commnetModel.images.length}");
                                  if (index == 3 && numImages > 4) {
                                    //Last Image
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          PictureView(
                                            commentModel: widget.commnetModel,
                                            initialPage: index,
                                            commentImage: true,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: widget.commnetModel
                                                          .images[0].url !=
                                                      null
                                                  ? Image.network(
                                                      widget.commnetModel
                                                          .images[0].url!,
                                                      fit: BoxFit.cover)
                                                  : Image.file(
                                                      widget.commnetModel
                                                          .images[0].filePath!,
                                                      fit: BoxFit.cover),
                                            ),
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.blackColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '+' + remaining.toString(),
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color:
                                                          AppColors.whiteColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          PictureView(
                                            commentModel: widget.commnetModel,
                                            initialPage: index,
                                            commentImage: true,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: widget.commnetModel.images[0]
                                                      .url !=
                                                  null
                                              ? Image.network(
                                                  widget.commnetModel.images[0]
                                                      .url!,
                                                  fit: BoxFit.cover)
                                              : Image.file(
                                                  widget.commnetModel.images[0]
                                                      .filePath!,
                                                  fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              staggeredTileBuilder: (int index) {
                                if (index == 0) {
                                  return const StaggeredTile.count(3, 3);
                                } else {
                                  return const StaggeredTile.count(1, 1);
                                }
                              },
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                            ),
                          )
                        :
                        //---------Show Only one Image
                        GestureDetector(
                            onTap: () {
                              Get.to(
                                PictureView(
                                  commentModel: widget.commnetModel,
                                  initialPage: 0,
                                  commentImage: true,
                                ),
                              );
                            },
                            child: Container(
                                width: queryData.size.width,
                                height: queryData.size.height * 0.32,
                                margin: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.mainPurpleColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: widget.commnetModel.images[0].url !=
                                          null
                                      ? Image.network(
                                          widget.commnetModel.images[0].url!,
                                          fit: BoxFit.cover)
                                      : Image.file(
                                          widget
                                              .commnetModel.images[0].filePath!,
                                          fit: BoxFit.cover),
                                )),
                          )
                    : SizedBox(
                        height: queryData.size.height * 0.01,
                      ),
                //========================================================================
                SizedBox(
                  height: queryData.size.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: queryData.size.width * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          homeVM.postID = widget.commnetModel.postId;
                          homeVM.parentCommentID = widget.commnetModel.id;
                          homeVM.comment = widget.commnetModel;
                          homeVM.update();
                          print("Post ID :${homeVM.postID}");
                          print("parentCommentID :${homeVM.parentCommentID}");
                          FocusScope.of(context).requestFocus(homeVM.focusNode);
                        },
                        child: Row(
                          children: [
                            Image.asset(AppImages.commentIcon,
                                width: queryData.size.width * 0.06,
                                height: queryData.size.height * 0.04),
                            Padding(
                              padding: EdgeInsets.only(top: 8, left: 4),
                              child: Text(
                                widget.commnetModel.childrenComments!.length
                                    .toString(),
                                style: AppTextStyle.ModernEra(
                                  AppColors.darkGreyColor,
                                  12.sp,
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //--------------------
                      Spacer(),
                      authPro.userModel!.id == widget.commnetModel.user.id
                          ? SizedBox()
                          : Row(
                              children: [
                                //-----Like
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isLiked = !_isLiked;
                                      if (_isLiked) {
                                        _likesCount++;
                                        LikedDisLike(widget.commnetModel.id, 1);
                                        //----Check Dislike----
                                        if (_disLiked) {
                                          _disLiked = !_disLiked;
                                          _dislikeCount--;
                                        }
                                        //-----------------------
                                      } else {
                                        _likesCount--;
                                        LikedDisLike(widget.commnetModel.id, 1);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          _isLiked
                                              ? AppImages.likedfill
                                              : AppImages.likeFlag,
                                          width: queryData.size.width * 0.06,
                                          height: queryData.size.height * 0.04),
                                      SizedBox(
                                        width: queryData.size.width * 0.01,
                                      ),
                                      Container(
                                        width: 2,
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          (widget.commnetModel.likesCounter +
                                                  _likesCount)
                                              .toString(),
                                          style: AppTextStyle.ModernEra(
                                            AppColors.greenColor,
                                            12.sp,
                                            FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //-----------
                                SizedBox(
                                  width: queryData.size.width * 0.05,
                                ),
                                //-----------
                                //-----DisLike
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _disLiked = !_disLiked;
                                      if (_disLiked) {
                                        LikedDisLike(widget.commnetModel.id, 0);
                                        _dislikeCount++;
                                        //----Check like---------
                                        if (_isLiked) {
                                          _isLiked = !_isLiked;
                                          _likesCount--;
                                        }
                                        //-----------------------
                                      } else {
                                        _dislikeCount--;
                                        LikedDisLike(widget.commnetModel.id, 0);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          _disLiked
                                              ? AppImages.disLikeFill
                                              : AppImages.dilikeFlag,
                                          width: queryData.size.width * 0.06,
                                          height: queryData.size.height * 0.04),
                                      SizedBox(
                                        width: queryData.size.width * 0.01,
                                      ),
                                      Container(
                                        width: 2,
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          (widget.commnetModel.dislikesCounter +
                                                  _dislikeCount)
                                              .toString(),
                                          style: AppTextStyle.ModernEra(
                                            AppColors.redColor,
                                            12.sp,
                                            FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.commnetModel.childrenComments!.isNotEmpty
              ? Container(
                  width: queryData.size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          "Replies",
                          style: AppTextStyle.ModernEra(
                            AppColors.darkGreyColor,
                            12.sp,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      Column(
                        children: List.generate(
                          widget.commnetModel.childrenComments!.length,
                          (index) {
                            return Column(
                              children: [
                                ReplyWidget(
                                  commnet: widget
                                      .commnetModel.childrenComments![index],
                                ),
                                SizedBox(
                                  height: queryData.size.height * 0.015,
                                ),
                                index ==
                                        widget.commnetModel.childrenComments!
                                                .length -
                                            1
                                    ? SizedBox()
                                    : Divider(
                                        color: AppColors.darkGreyColor,
                                        height: 5,
                                      ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.01,
                      ),
                      Container(
                        color: AppColors.whiteColor,
                        width: queryData.size.width,
                        height: queryData.size.height * 0.065,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            readOnly: true,
                            decoration:
                                AppInputDecoration.circularFieldDecoration(
                              Container(
                                  padding: EdgeInsets.all(12),
                                  width: queryData.size.width * 0.05,
                                  child: Image.asset(
                                    AppImages.uploadingImg,
                                  )),
                              'reply',
                              null,
                            ),
                            onTap: () {
                              setState(() {});
                              FocusScope.of(context)
                                  .requestFocus(homeVM.focusNode);
                              int? postid = widget.commnetModel.postId;
                              homeVM.postID = postid;
                              int? pC = widget.commnetModel.id;
                              homeVM.parentCommentID = pC;
                              homeVM.comment = widget.commnetModel;
                              homeVM.update();
                              print(
                                  "The Commnet Model is${widget.commnetModel}");
                              print("Post ID ${widget.commnetModel.postId}");
                              print(
                                  "parentCommentID  :${widget.commnetModel.id}");
                              //=========================
                              print("Post ID ${homeVM.postID}");
                              print(
                                  "parentCommentID  :${homeVM.parentCommentID}");
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.01,
                      ),
                    ],
                  ),
                )
              : SizedBox(),
        ],
      );
    });
  }

  //------------------------------
  _showDialog(String title, String description, String btnOneText,
      Function()? onCancle, String btnTwoText, Function()? onTap2) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Text(
                title ?? "",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  17.sp,
                  FontWeight.w600,
                ),
              ),
              content: Text(
                description ?? "",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  13.sp,
                  FontWeight.w400,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: onCancle,
                  child: Text(
                    getTranslated(context, btnOneText) ?? "",
                    style: AppTextStyle.ModernEra(
                      AppColors.blueColor,
                      17.sp,
                      FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onTap2,
                  child: Text(
                    getTranslated(context, btnTwoText) ?? "",
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

  void LikedDisLike(int commentID, int status) async {
    print("Post ID is :${commentID}");
    print("Status is :${status}");
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'comment_id': '${commentID}',
          'is_liked': '${status}',
        },
        '/posts/comments/react',
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

  //------------Delete Comment-----------------------------------
  void deleteCommemt(int commentID) async {
    print('Repost Called in Comment');
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'comment_id': '${commentID}',
          'reason': 'null',
          'additional_note': 'null',
        },
        '/posts/comments/report',
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
  //===================================================================
  //================================================================================
  PopupMenuButton<String> tralingPopups(
      MediaQueryData queryData, AuthVM authPro, HomeVM homePro) {
    print("---The User Id is ${authPro.userModel!.id}--Widget id ${widget.commnetModel.userId}");
    return PopupMenuButton<String>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      icon: Image.asset(AppImages.moreIcon,
          width: queryData.size.width * 0.06,
          height: queryData.size.height * 0.04),
      color: AppColors.dropDownColor,
      padding: EdgeInsets.zero,
      onSelected: (String value) {
        setState(() {});
        //----Check where it is delete Popup or not
        if (widget.commnetModel.userId == authPro.userModel!.id) {
          if (value == 'Option 1') {
            Helper.showDialog(
                'Delete Post',
                'Are you sure you want to delete this Post?',
                'cancel',
                    () {
                  Navigator.of(context).pop();
                },
                'delete',
                    () {
                  Get.back();
                  Navigator.of(context).pop();
                  homePro.postitems.remove(widget.commnetModel);
                  homePro.update();
                  Helper.deletePost(widget.commnetModel.id);
                },
                context);
          }
        } else {
          if (value == 'Option 1') {
            Helper.showDialog(
                'Block @${widget.commnetModel.user.username}',
                '@${widget.commnetModel.user.username} will no longer be able to view  your post and you will not be able to view posts from ${widget.commnetModel.user.username}',
                'cancel',
                    () {
                  Navigator.of(context).pop();
                },
                'block',
                    () {
                  Helper.blockUser(widget.commnetModel.user.id);
                  Navigator.of(context).pop();
                },
                context);
          } else {
            Helper.showDialog(
                'Report Post from @${widget.commnetModel.user.username}',
                'Comment from @${widget.commnetModel.user.username} reported',
                'cancel',
                    () {
                  Navigator.of(context).pop();
                },
                'report',
                    () {
                  Helper.reportPost(widget.commnetModel.id);
                  Navigator.of(context).pop();
                },
                context);
          }
        }
        print("*****The Selected VAlue is ${value}");
      },
      itemBuilder: (BuildContext context) =>
      widget.commnetModel.userId != authPro.userModel!.id
          ? <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            value: 'Option 1',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: queryData.size.width * 0.55,
                  child: Text(
                    'Block @${widget.commnetModel.user.username}',
                    style: AppTextStyle.ModernEra(
                        AppColors.blackColor, 14.sp, FontWeight.w600),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Image.asset(AppImages.blockBlack,
                    width: queryData.size.width * 0.06,
                    height: queryData.size.height * 0.04),
              ],
            )),
        PopupMenuItem<String>(
          value: 'Option 2',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: queryData.size.width * 0.5,
                child: Text(
                  'Report post from @${widget.commnetModel.user.username}',
                  style: AppTextStyle.ModernEra(
                      AppColors.blackColor, 14.sp, FontWeight.w600),
                ),
              ),
              Image.asset(AppImages.flag,
                  width: queryData.size.width * 0.06,
                  height: queryData.size.height * 0.04),
            ],
          ),
        ),
      ]
          :
      //===Delete PopUP
      <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            value: 'Option 1',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: queryData.size.width * 0.55,
                  child: Text(
                    'Delete Post',
                    style: AppTextStyle.ModernEra(
                        AppColors.blackColor, 14.sp, FontWeight.w600),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Image.asset(AppImages.deleteIcon,
                    width: queryData.size.width * 0.06,
                    height: queryData.size.height * 0.04),
              ],
            )),
      ],
    );
  }
//=====================================================================
  //-----------------------------------------------------------
  void blockUser(int userID) async {
    print('Repost Called in Comment');
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'user_id': '${userID}',
        },
        '/user/block',
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
