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
import '../../../auth/view_model/auth_vm.dart';
import '../model/post_model.dart';
import '../view/pages/picture_view.dart';

class PostWidget extends StatefulWidget {
  Datum model;
  bool ispostOpen;
  PostWidget({
    Key? key,
    this.ispostOpen = false,
    required this.model,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
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
    return Consumer2<AuthVM,HomeVM>(
      builder: (context, authPro,homePro, _) {
        return Container(
          width: queryData.size.width,
          margin: widget.ispostOpen == false
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          padding: const EdgeInsets.symmetric(horizontal: 12) +
              const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topRight: widget.ispostOpen == false
                  ? Radius.circular(10)
                  : Radius.circular(0),
              topLeft: widget.ispostOpen == false
                  ? Radius.circular(10)
                  : Radius.circular(0),
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
                trailing:tralingPopups(queryData,authPro,homePro),
              ),
              Text(
                widget.model.description ?? "",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  12.sp,
                  FontWeight.w500,
                ),
              ),


              widget.model.images.isNotEmpty
                  ? widget.model.images.length > 1
                      ?
                      //----Show Multiples Images---------
                      Container(
                          width: queryData.size.width,
                          height: queryData.size.height * 0.5,
                          margin: EdgeInsets.symmetric(vertical: 12),
                          child: StaggeredGridView.countBuilder(
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            itemCount: widget.model.images.length >= 4
                                ? 4
                                : widget.model.images.length,
                            itemBuilder: (BuildContext context, int index) {
                              int maxImages = 4;
                              int numImages = widget.model.images.length;
                              // Check how many more images are left
                              int remaining = numImages - maxImages;
                              String imageUrl = widget.model.images[index].url;
                              if (index == 0) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      PictureView(
                                        model: widget.model,
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
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                print(
                                    "---index:${index}----imageURL:${widget.model.images.length}");
                                if (index == 3 && numImages > 4) {
                                  //Last Image
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        PictureView(
                                          model: widget.model,
                                          initialPage: index,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(imageUrl,
                                                  fit: BoxFit.cover)),
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
                                          model: widget.model,
                                          initialPage: index,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(imageUrl,
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                }
                              }
                            },
                            staggeredTileBuilder: (int index) {
                              if (index == 0) {
                                return StaggeredTile.count(3, 3);
                              } else {
                                return StaggeredTile.count(1, 1);
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
                                model: widget.model,
                                initialPage: 0,
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
                                child: Image.network(widget.model.images[0].url,
                                    fit: BoxFit.cover),
                              )),
                        )
                  : SizedBox(
                      height: queryData.size.height * 0.01,
                    ),

              //-------------------------------------------------------------------------------------
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
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: List.generate(
                                  widget.model.flagCount ?? 1, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    AppImages.redFlag,
                                    width: queryData.size.width * 0.05,
                                    height: queryData.size.height * 0.04,
                                  ),
                                );
                              }),
                            ),
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

              //----Commnet and LIke/Dislike section----------------------
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: queryData.size.width * 0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //--------------------
                    GestureDetector(
                      onTap: widget.ispostOpen == false
                          ? () {
                              Get.to(PostView(
                                model: widget.model,
                              ));
                            }
                          : () {},
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.commentIcon,
                            width: queryData.size.width * 0.06,
                            height: queryData.size.height * 0.04,
                          ),
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
                    ),
                    //--------------------
                    Spacer(),
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
                                      height: queryData.size.height * 0.04,
                                    ),
                                    SizedBox(
                                      width: queryData.size.width * 0.01,
                                    ),
                                    Container(
                                      width: 2,
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        (widget.model.likesCounter +
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
                                      height: queryData.size.height * 0.04,
                                    ),
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
      },
    );
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
  PopupMenuButton<String> tralingPopups(MediaQueryData queryData,AuthVM authPro,HomeVM homePro){
    return  PopupMenuButton<String>(
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
        if(widget.model.userId == authPro.userModel!.id){
          if (value == 'Option 1')
          {
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
                  homePro.postitems.remove(widget.model);
                  homePro.update();
                Helper.deletePost(widget.model.id);
                },context);
          }
        }else{
          if (value == 'Option 1')
          {
            Helper.showDialog(
                'Block @${widget.model.user.username}',
                '@${widget.model.user.username} will no longer be able to view  your post and you will not be able to view posts from ${widget.model.user.username}',
                'cancel',
                    () {
                  Navigator.of(context).pop();
                },
                'block',
                    () {
                      Helper.  blockUser(widget.model.user.id);
                  Navigator.of(context).pop();
                },
            context);
          } else
          {
            Helper. showDialog(
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
                },context);
          }
        }
        print("*****The Selected VAlue is ${value}");
      },
      itemBuilder: (BuildContext context) =>
      widget.model.userId != authPro.userModel!.id?
      <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            value: 'Option 1',
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: queryData.size.width * 0.55,
                  child: Text(
                    'Block @${widget.model.user.username}',
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
                  'Report post from @${widget.model.user.username}',
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
      ]:
      //===Delete PopUP
      <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            value: 'Option 1',
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: queryData.size.width * 0.55,
                  child: Text(
                    'Delete Post',
                    style: AppTextStyle.ModernEra(
                        AppColors.blackColor,
                        14.sp,
                        FontWeight.w600),
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
