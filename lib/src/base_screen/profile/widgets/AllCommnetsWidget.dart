import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/src/base_screen/profile/widgets/comment_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../localization/app_localization.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/text_styles.dart';
import '../../home/view/pages/picture_view.dart';
import '../../home/view_model/home_vm.dart';
import '../model/allMyComment_model.dart';

class AllCommentsWidget extends StatefulWidget {
  final DatumALlMyComments datumALlMyComments;
  AllCommentsWidget({
    Key? key,
    required this.datumALlMyComments,
  }) : super(key: key);

  @override
  State<AllCommentsWidget> createState() => _AllCommentsWidgetState();
}

class _AllCommentsWidgetState extends State<AllCommentsWidget> {
  String _selectedOption = 'Option 1';
  //=================
  bool _isLiked = false;
  int _likesCount = 0;
  //=================
  bool _disLiked = false;
  int _dislikeCount = 0;
//---------------------------------------------------------------
//---------------------------------------------------------------
  TextEditingController replyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer2<HomeVM,AuthVM>(builder: (context, homeVM,authPro, _) {
      return Container(
        width: queryData.size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.whiteColor,
        ),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10)+EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              height:60,
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: ListTile(
                title: Text(widget.datumALlMyComments.name??"",
                  style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    14.sp,
                    FontWeight.w700,
                  ),
                ),
                subtitle: Text('${widget.datumALlMyComments.totalMembers} members'??"",
                  style: AppTextStyle.ModernEra(
                    AppColors.darkGreyColor,
                    10.sp,
                    FontWeight.w500,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: (){},
                  child: Text(getTranslated(context,'view_group')??"",
                    style: AppTextStyle.ModernEra(
                      AppColors.mainPurpleColor,
                      12.sp,
                      FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Divider(
              color: AppColors.darkGreyColor,
            ),
            Column(
              children: List.generate(
                  widget.datumALlMyComments.comments.length,
                      (index){
                    var comment=widget.datumALlMyComments.comments[index];
                return  GestureDetector(
                  onTap: (){
                    Get.to(CommentViewWidgt(postId: comment.postId,));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: comment.isAnonymous == 0
                                  ? CircleAvatar(
                                backgroundImage: NetworkImage(authPro.userModel!.avatar),
                                radius: 25,
                              )
                                  : CircleAvatar(
                                backgroundImage:
                                NetworkImage(authPro.userModel!.blurredAvatar),
                                radius: 25,
                              ),
                              title: comment.isAnonymous == 0
                                  ? Row(
                                children: [
                                  Text(
                                    authPro.userModel!.name,
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
                                      authPro.userModel!.username,
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
                                widget.datumALlMyComments.comments[index].createdAt,
                                style: AppTextStyle.ModernEra(
                                  AppColors.darkGreyColor,
                                  12.sp,
                                  FontWeight.w500,
                                ),
                              ),
                              trailing:  GestureDetector(
                                onTap: (){
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Image.asset(AppImages.moreIcon,width: queryData.size.width*0.06,)),
                              ),

                              // PopupMenuButton<String>(
                              //   shape: const RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.all(
                              //       Radius.circular(20.0),
                              //     ),
                              //   ),
                              //   icon: Image.asset(AppImages.moreIcon,
                              //       width: queryData.size.width * 0.06,
                              //       height: queryData.size.height * 0.04),
                              //   color: AppColors.dropDownColor,
                              //   padding: EdgeInsets.zero,
                              //   onSelected: (String value) {
                              //     setState(() {});
                              //     print("*****The Selected VAlue is ${value}");
                              //     if (value == 'Option 1') {
                              //       _showDialog(
                              //           'Block @monika',
                              //           '@monika will no longer be able to view  your post and you will not be able to view posts from @monika',
                              //           'cancel', () {
                              //         Navigator.of(context).pop();
                              //       }, 'block', () {});
                              //     } else {
                              //       _showDialog(
                              //           'Delete comment from @monika',
                              //           'Comment from @monika will no longer be visible under your post',
                              //           'cancel', () {
                              //         Navigator.of(context).pop();
                              //       }, 'delete', () {});
                              //     }
                              //   },
                              //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              //     PopupMenuItem<String>(
                              //         value: 'Option 1',
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Text(
                              //               'Block @monika',
                              //               style: AppTextStyle.ModernEra(
                              //                   AppColors.blackColor, 14.sp, FontWeight.w600),
                              //             ),
                              //             Image.asset(AppImages.blockBlack,
                              //                 width: queryData.size.width * 0.06,
                              //                 height: queryData.size.height * 0.04),
                              //           ],
                              //         )),
                              //     PopupMenuItem<String>(
                              //       value: 'Option 2',
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           SizedBox(
                              //             width: queryData.size.width * 0.5,
                              //             child: Text(
                              //               'Report comment from @monika',
                              //               style: AppTextStyle.ModernEra(
                              //                   AppColors.blackColor, 14.sp, FontWeight.w600),
                              //             ),
                              //           ),
                              //           Image.asset(AppImages.flag,
                              //               width: queryData.size.width * 0.06,
                              //               height: queryData.size.height * 0.04),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                            Text(
                              comment.body ?? "",
                              style: AppTextStyle.ModernEra(
                                AppColors.blackColor,
                                12.sp,
                                FontWeight.w500,
                              ),
                            ),
                            //=======================================================================
                            comment.images.isNotEmpty
                                ? comment.images.length > 1
                                ?
                            //----Show Multiples Images---------
                            Container(
                              width: queryData.size.width,
                              height: queryData.size.height * 0.5,
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: StaggeredGridView.countBuilder(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                itemCount: comment.images.length >= 4
                                    ? 4
                                    : comment.images.length,
                                itemBuilder: (BuildContext context, int index) {
                                  int maxImages = 4;
                                  int numImages = comment.images.length;
                                  // Check how many more images are left
                                  int remaining = numImages - maxImages;
                                  // String imageUrl = widget.commnet.images[index].url;
                                  if (index == 0) {
                                    return GestureDetector(
                                        onTap: () {
                                          // Get.to(PictureView(
                                          //   commentModel:widget.commnet,
                                          //   commentImage:true,
                                          //   initialPage: index,
                                          // ),);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.blackColor,
                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              child: Image.network(
                                                  comment.images[0].url,
                                                  fit: BoxFit.cover),
                                            ),),);
                                  } else {
                                    // print(
                                    //     "---index:${index}----imageURL:${widget.commnet.images.length}");
                                    if (index == 3 && numImages > 4) {
                                      //Last Image
                                      return GestureDetector(
                                        onTap: () {
                                          // Get.to(PictureView(
                                          //   commentModel:widget.commnet,
                                          //   initialPage: index,
                                          //   commentImage:true,
                                          // ),);
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
                                                child: Image.network(
                                                    comment.images[0].url,
                                                    fit: BoxFit.cover),
                                              ),
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.blackColor
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '+' + remaining.toString(),
                                                    style: TextStyle(
                                                        fontSize: 32,
                                                        color: AppColors
                                                            .whiteColor),
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
                                          // Get.to(PictureView(
                                          //   commentModel: widget.commnet,
                                          //   initialPage: index,
                                          //   commentImage: true,
                                          // ),);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            child: Image.network(
                                                comment.images[0].url,
                                                fit: BoxFit.cover),
                                          ),
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
                                // Get.to(PictureView(
                                //   commentModel: widget.commnet,
                                //   initialPage: 0,
                                //   commentImage: true,
                                // ),);
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
                                  child: Image.network(
                                      comment.images[0].url,
                                      fit: BoxFit.cover),
                                ),
                              ),
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
                                    onTap:  () {},
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
                                            comment.repliesCounter.toString(),
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
                                  //-----Like
                                  GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   _isLiked = !_isLiked;
                                      //   if (_isLiked) {
                                      //     _likesCount++;
                                      //     LikedDisLike(widget.commnet.id,1);
                                      //     //----Check Dislike----
                                      //     if(_disLiked) {
                                      //       _disLiked=!_disLiked;
                                      //       _dislikeCount--;
                                      //     }
                                      //     //-----------------------
                                      //   } else {
                                      //     _likesCount--;
                                      //   }
                                      // });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(AppImages.likeFlag,
                                            width: queryData.size.width * 0.06,
                                            height: queryData.size.height * 0.04),
                                        SizedBox(
                                          width: queryData.size.width * 0.01,
                                        ),
                                        Container(
                                          width: 2,
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            comment.likesCounter.toString(),
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
                                      // setState(() {
                                      //   _disLiked = !_disLiked;
                                      //   if (_disLiked) {
                                      //     LikedDisLike(widget.commnet.id,0);
                                      //     _dislikeCount++;
                                      //     //----Check like---------
                                      //     if(_isLiked) {
                                      //       _isLiked=!_isLiked;
                                      //       _likesCount--;
                                      //     }
                                      //     //-----------------------
                                      //   } else {
                                      //     _dislikeCount--;
                                      //   }
                                      // });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(AppImages.dilikeFlag,
                                            width: queryData.size.width * 0.06,
                                            height: queryData.size.height * 0.04),
                                        SizedBox(
                                          width: queryData.size.width * 0.01,
                                        ),
                                        Container(
                                          width: 2,
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            comment.dislikesCounter.toString(),
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
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.01,
                            ),
                            //========================================================================
                          ],
                        ),
                      ),
                      index ==
                          widget.datumALlMyComments.comments
                              .length -
                              1
                          ? SizedBox()
                          : Divider(
                        color: AppColors.darkGreyColor,
                        height: 5,
                      ),
                    ],
                  ),
                );
              },),
            ),
          ],
        ),
      );
    });
  }

  //-------------------------------------------------------------------------------------
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
        },);
  }
//-------------------------------------------------------------------------------------

}
