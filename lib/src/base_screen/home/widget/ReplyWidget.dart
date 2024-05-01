

import 'package:dateify_project/resources/app_colors.dart';
import 'package:dateify_project/resources/app_images.dart';
import 'package:dateify_project/resources/input.decorations.dart';
import 'package:dateify_project/src/base_screen/home/model/comment_model.dart';
import 'package:dateify_project/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../backend/api_request.dart';
import '../../../../localization/app_localization.dart';
import '../../../../resources/text_styles.dart';
import '../../../auth/view_model/auth_vm.dart';
import '../view/pages/picture_view.dart';
import '../view_model/home_vm.dart';

class ReplyWidget extends StatefulWidget {
  Comment  commnet;
   ReplyWidget({Key? key, required this.commnet}) : super(key: key);

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  String _selectedOption = 'Option 1';
  //=================
  bool _isLiked = false;
  int _likesCount = 0;
  //=================
  bool _disLiked = false;
  int _dislikeCount = 0;
  //---------------------------------------------------------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("reaction Type    :${widget.commnet.reactionType}");
      if (widget.commnet.reactionType == "dislike") {
        setState(() {
          _disLiked = true;
        });
      } else if (widget.commnet.reactionType == "like") {
        setState(() {
          _isLiked = true;
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }
  //---------------------------------------------------------------
  TextEditingController replyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer2<HomeVM,AuthVM>(builder: (context,homeVM,authPro,_){
      return Container(
        width: queryData.size.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.whiteColor,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:   CircleAvatar(
                      backgroundImage:
                      NetworkImage(widget.commnet.user.avatar),
                      radius: 25,
                    ),
                    title: Row(
                      children: [
                        Text(widget.commnet.user.name,
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
                          child: Text(widget.commnet.user.username,
                            style: AppTextStyle.ModernEra(
                              AppColors.darkGreyColor,
                              12.sp,
                              FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(widget.commnet.createdAt,
                      style: AppTextStyle.ModernEra(
                        AppColors.darkGreyColor,
                        12.sp,
                        FontWeight.w500,
                      ),
                    ),
                    trailing: authPro.userModel!.id!=widget.commnet.userId?
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
                              'Block @${widget.commnet.user.username}',
                              '@${widget.commnet.user.username} will no longer be able to view  your post and you will not be able to view posts from @monika',
                              'cancel',
                                  () {
                                Navigator.of(context).pop();
                              },
                              'block',
                                  () {
                            Helper.    blockUser(widget.commnet.user.id);
                                Navigator.of(context).pop();
                              });
                        } else {
                          _showDialog(
                              'Report comment from @${widget.commnet.user.username}',
                              'Comment from @${widget.commnet.user.username} reported',
                              'cancel',
                                  () {
                                Navigator.of(context).pop();
                              },
                              'delete',
                                  () {
                                deleteCommemt(widget.commnet.id);
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
                                    'Block @${widget.commnet.user.username}',
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
                                  'Report comment from @${widget.commnet.user.username}',
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
                    // trailing:PopupMenuButton<String>(
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(20.0),
                    //     ),
                    //   ),
                    //   icon: Image.asset(AppImages.moreIcon,width: queryData.size.width*0.06,height: queryData.size.height*0.04),
                    //   color: AppColors.dropDownColor,
                    //   padding: EdgeInsets.zero,
                    //   onSelected: (String value) {
                    //     setState(() {
                    //       _selectedOption = value;
                    //     });
                    //     print(
                    //         "*****The Selected VAlue is ${value}");
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
                    //   itemBuilder: (BuildContext context) =>
                    //   <PopupMenuEntry<String>>[
                    //     PopupMenuItem<String>(
                    //         value: 'Option 1',
                    //         child: Row(
                    //           mainAxisAlignment:
                    //           MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               'Block @monika',
                    //               style: AppTextStyle.ModernEra(
                    //                   AppColors.blackColor,
                    //                   14.sp,
                    //                   FontWeight.w600),
                    //             ),
                    //             Image.asset(AppImages.blockBlack,width: queryData.size.width*0.06,height: queryData.size.height*0.04),
                    //           ],
                    //         )),
                    //     PopupMenuItem<String>(
                    //       value: 'Option 2',
                    //       child: Row(
                    //         mainAxisAlignment:
                    //         MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           SizedBox(
                    //             width: queryData.size.width * 0.5,
                    //             child: Text(
                    //               'Report comment from @monika',
                    //               style: AppTextStyle.ModernEra(
                    //                   AppColors.blackColor,
                    //                   14.sp,
                    //                   FontWeight.w600),
                    //             ),
                    //           ),
                    //           Image.asset(AppImages.flag,width: queryData.size.width*0.06,height: queryData.size.height*0.04),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // GestureDetector(
                    //   onTap: (){
                    //     widget.moreOnPressed();
                    //     setState(() {
                    //
                    //     });
                    //   },
                    //   child: Padding(
                    //       padding: EdgeInsets.only(bottom: 20),
                    //       child: Image.asset(AppImages.moreIcon)),
                    // ),

                  ),
                  Text(widget.commnet.body??"",
                    style: AppTextStyle.ModernEra(
                      AppColors.blackColor,
                      12.sp,
                      FontWeight.w500,
                    ),
                  ),
                  //=======================================================================
                  widget.commnet.images.isNotEmpty
                      ?
                  widget.commnet.images.length>1?
                  //----Show Multiples Images---------
                  Container(
                    width: queryData.size.width,
                    height: queryData.size.height * 0.5,
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: StaggeredGridView.countBuilder(
                      physics:NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      itemCount: widget.commnet.images.length >= 4
                          ? 4
                          : widget.commnet.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        int maxImages = 4;
                        int numImages = widget.commnet.images.length;
                        // Check how many more images are left
                        int remaining = numImages - maxImages;
                        // String imageUrl = widget.commnet.images[index].url;
                        if (index == 0) {
                          return GestureDetector(
                            onTap:(){
                              Get.to(PictureView(
                                commentModel:widget.commnet,
                                commentImage:true,
                                initialPage: index,
                              ),);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.blackColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:
                                widget.commnet.images[0].url!=null?
                                Image.network(
                                    widget.commnet.images[0].url!,
                                    fit: BoxFit.cover):
                                Image.file(
                                    widget.commnet.images[0].filePath!,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          );
                        } else {
                          // print(
                          //     "---index:${index}----imageURL:${widget.commnet.images.length}");
                          if (index == 3&&numImages>4) {
                            //Last Image
                            return GestureDetector(
                              onTap:(){
                                Get.to(PictureView(
                                  commentModel:widget.commnet,
                                  initialPage: index,
                                  commentImage:true,
                                ),);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                        widget.commnet.images[0].url!=null?
                                        Image.network(
                                            widget.commnet.images[0].url!,
                                            fit: BoxFit.cover):
                                        Image.file(
                                            widget.commnet.images[0].filePath!,
                                            fit: BoxFit.cover),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                          AppColors.blackColor.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '+' + remaining.toString(),
                                          style: TextStyle(
                                              fontSize: 32,
                                              color: AppColors.whiteColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap:(){
                                Get.to(PictureView(
                                  commentModel: widget.commnet,
                                  initialPage: index,
                                  commentImage: true,
                                ),);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child:
                                    widget.commnet.images[0].url!=null?
                                    Image.network(
                                        widget.commnet.images[0].url!,
                                        fit: BoxFit.cover):
                                    Image.file(
                                        widget.commnet.images[0].filePath!,
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
                  ):
                  //---------Show Only one Image
                  GestureDetector(
                    onTap:(){
                      Get.to(PictureView(
                        commentModel: widget.commnet,
                        initialPage: 0,
                        commentImage: true,
                      ),);
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
                          child:     widget.commnet.images[0].url!=null?
                          Image.network(
                              widget.commnet.images[0].url!,
                              fit: BoxFit.cover):
                          Image.file(
                              widget.commnet.images[0].filePath!,
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
                    padding:  EdgeInsets.symmetric(horizontal: queryData.size.width * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //--------------------
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _isLiked = !_isLiked;
                              if (_isLiked) {
                                _likesCount++;
                                LikedDisLike(widget.commnet.id,1);
                                //----Check Dislike----
                                if(_disLiked) {
                                  _disLiked=!_disLiked;
                                  _dislikeCount--;
                                }
                                //-----------------------
                              } else {
                                _likesCount--;
                                LikedDisLike(widget.commnet.id,1);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset(_isLiked?AppImages.likedfill:AppImages.likeFlag,width: queryData.size.width*0.06,height: queryData.size.height*0.04),
                              SizedBox(
                                width: queryData.size.width * 0.01,
                              ),
                              Container(
                                width: 2,
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                  (widget.commnet.likesCounter+_likesCount).toString(),
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
                          onTap: (){
                            setState(() {
                              _disLiked = !_disLiked;
                              if (_disLiked) {
                                LikedDisLike(widget.commnet.id,0);
                                _dislikeCount++;
                                //----Check like---------
                                if(_isLiked) {
                                  _isLiked=!_isLiked;
                                  _likesCount--;
                                }
                                //-----------------------
                              } else {
                                _dislikeCount--;
                                LikedDisLike(widget.commnet.id,0);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset( _disLiked?AppImages.disLikeFill:AppImages.dilikeFlag,width: queryData.size.width*0.06,height: queryData.size.height*0.04),
                              SizedBox(
                                width: queryData.size.width * 0.01,
                              ),
                              Container(
                                width: 2,
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                  (widget.commnet.dislikesCounter+_dislikeCount).toString(),
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
                  //========================================================================
                ],
              ),
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
        });
  }
  //-------------------------------------------------------------------------------------

  void LikedDisLike(int commentID,int status) async{
    var token=await Helper.Token();
    Services.postApiWithHeaders(
        {
          'comment_id':'${commentID}',
          'is_liked':'${status}',
        },
        '/posts/comments/react',
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }
    ).then((data){
      print("------{$data}--------");
      final match=data["success"];
      if(match==true){
        Helper.ToastFlutter(data["description"]);
      }else{
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
}
