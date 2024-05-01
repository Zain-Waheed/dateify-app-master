import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/src/base_screen/home/view/post_view.dart';
import 'package:dateify_project/src/base_screen/home/view_model/home_vm.dart';
import 'package:dateify_project/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../backend/api_request.dart';
import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import '../model/post_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PostViewWidget extends StatefulWidget {
  Datum model;
  PostViewWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<PostViewWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostViewWidget> {
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
      print("reaction Type    :${widget.model.reactionType}");
      if (widget.model.reactionType == "dislike") {
        setState(() {
          _disLiked = true;
        });
      } else if (widget.model.reactionType == "like") {
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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer2<AuthVM, HomeVM>(builder: (context, authPro, homeVM, _) {
      return Container(
        width: queryData.size.width,
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        padding:
            EdgeInsets.symmetric(horizontal: 12) + EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(0),
            topLeft: Radius.circular(0),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: widget.model.isAnonymous == 0
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.model.user.avatar),
                      radius: 25,
                    )
                  : CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.model.user.blurredAvatar),
                      radius: 25,
                    ),
              title: widget.model.isAnonymous == 0
                  ? Row(
                      children: [
                        Text(
                          widget.model.user.name,
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
                            widget.model.user.username,
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
                widget.model.createdAt,
                style: AppTextStyle.ModernEra(
                  AppColors.darkGreyColor,
                  12.sp,
                  FontWeight.w500,
                ),
              ),
              trailing: tralingPopups(queryData, authPro, homeVM),
            ),

            Text(
              widget.model.description ?? "",
              style: AppTextStyle.ModernEra(
                AppColors.blackColor,
                12.sp,
                FontWeight.w500,
              ),
            ),
            //--------------------------------------------------
            widget.model.images.isNotEmpty
                ? CarouselSlider.builder(
                    itemCount: widget.model.images.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                      width: queryData.size.width,
                      height: queryData.size.height * 0.32,
                      margin: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.mainPurpleColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(widget.model.images[itemIndex].url,
                            fit: BoxFit.cover),
                      ),
                    ),
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                  )
                : SizedBox(),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: List.generate(
            //         widget.model.images.length,
            //             (index){
            //           return Container(
            //             width: queryData.size.width,
            //             height: queryData.size.height * 0.32,
            //             margin: EdgeInsets.symmetric(vertical: 12),
            //             decoration: BoxDecoration(
            //               color: AppColors.mainPurpleColor,
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(20),
            //               child: Image.network(
            //                   widget.model.images[index].url,
            //                   fit: BoxFit.cover),
            //             ),
            //           );
            //             }),
            //   ),
            // ),
            //-----Show Flag---------------------------------------
            widget.model.isFlag == 1
                ? Container(
                    width: queryData.size.width,
                    height: queryData.size.height * 0.04,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 6, top: 6, bottom: 6),
                          child: Image.asset(AppImages.redFlag),
                        ),
                        Text(
                          widget.model.flagDescription ?? "",
                          style: AppTextStyle.ModernEra(
                            AppColors.darkGreyColor,
                            12.sp,
                            FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: queryData.size.height * 0.01,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: queryData.size.width * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //--------------------
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            homeVM.parentCommentID = null;
                            homeVM.postID = widget.model.id;
                            homeVM.update();
                            print("Post ID :${homeVM.postID}");
                            print("parentCommentID :${homeVM.parentCommentID}");
                            FocusScope.of(context)
                                .requestFocus(homeVM.focusNode);
                          },
                          child: Image.asset(AppImages.commentIcon,
                              width: queryData.size.width * 0.06,
                              height: queryData.size.height * 0.04)),
                      Padding(
                        padding: EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          widget.model.commentsCount.toString(),
                          style: AppTextStyle.ModernEra(
                            AppColors.darkGreyColor,
                            12.sp,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //--------------------
                  Spacer(),
                  //---------------------------------
                  authPro.userModel!.id == widget.model.user.id
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
                                    LikedDisLike(widget.model.id, 1);
                                    //----Check Dislike----
                                    if (_disLiked) {
                                      _disLiked = !_disLiked;
                                      _dislikeCount--;
                                    }
                                    //-----------------------
                                  } else {
                                    _likesCount--;
                                    LikedDisLike(widget.model.id, 1);
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
                                      (widget.model.likesCounter + _likesCount)
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
                                    LikedDisLike(widget.model.id, 0);
                                    _dislikeCount++;
                                    //----Check like---------
                                    if (_isLiked) {
                                      _isLiked = !_isLiked;
                                      _likesCount--;
                                    }
                                    //-----------------------
                                  } else {
                                    _dislikeCount--;
                                    LikedDisLike(widget.model.id, 0);
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
                                      (widget.model.dislikesCounter +
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
      );
    });
  }

//-------------------------------------------------------------------------
  void LikedDisLike(int postID, int status) async {
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'post_id': '${postID}',
          'is_liked': '${status}',
        },
        '/posts/react',
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

//-------------------------------------------------------------------------
//================================================================================
  PopupMenuButton<String> tralingPopups(
      MediaQueryData queryData, AuthVM authPro, HomeVM homePro) {
    print("---The User Id is ${authPro.userModel!.id}--Widget id ${widget.model.userId}");
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
        if (widget.model.userId == authPro.userModel!.id) {
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
                  homePro.postitems.remove(widget.model);
                  homePro.update();
                  Helper.deletePost(widget.model.id);
                },
                context);
          }
        } else {
          if (value == 'Option 1') {
            Helper.showDialog(
                'Block @${widget.model.user.username}',
                '@${widget.model.user.username} will no longer be able to view  your post and you will not be able to view posts from ${widget.model.user.username}',
                'cancel',
                () {
                  Navigator.of(context).pop();
                },
                'block',
                () {
                  Helper.blockUser(widget.model.user.id);
                  Navigator.of(context).pop();
                },
                context);
          } else {
            Helper.showDialog(
                'Report Post from @${widget.model.user.username}',
                'Comment from @${widget.model.user.username} reported',
                'cancel',
                () {
                  Navigator.of(context).pop();
                },
                'report',
                () {
                  Helper.reportPost(widget.model.id);
                  Navigator.of(context).pop();
                },
                context);
          }
        }
        print("*****The Selected VAlue is ${value}");
      },
      itemBuilder: (BuildContext context) =>
          widget.model.userId != authPro.userModel!.id
              ? <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                      value: 'Option 1',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: queryData.size.width * 0.55,
                            child: Text(
                              'Block @${widget.model.user.username}',
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
                            'Report post from @${widget.model.user.username}',
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
}
