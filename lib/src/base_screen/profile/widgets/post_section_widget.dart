import 'package:dateify_project/src/base_screen/home/view/post_view.dart';
import 'package:dateify_project/src/base_screen/profile/model/allMyPost_model.dart';
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
import '../../../auth/view_model/auth_vm.dart';
import '../../home/model/post_model.dart';
import '../../home/view/pages/picture_view.dart';

class PostSectionWidget extends StatefulWidget {
  final  DatumAllMyPosts datumAllMyPosts;
  PostSectionWidget({Key? key, required this.datumAllMyPosts}) : super(key: key);

  @override
  State<PostSectionWidget> createState() => _PostSectionWidgetState();
}

class _PostSectionWidgetState extends State<PostSectionWidget> {
  List<ImagePicP> imagesPicP = [];
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
   return Consumer<AuthVM>(builder: (context,authPro,_){
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            //   child: Text("Wating for approvel",
            //     style: AppTextStyle.ModernEra(
            //       AppColors.darkGreyColor,
            //       12.sp,
            //       FontWeight.w500,
            //     ),
            //   ),
            // ),
            Container(width: queryData.size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(
                    width: 1,
                    color: AppColors
                        .greyColor //                   <--- border width here
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor,
                    spreadRadius: -1,
                    blurRadius: 1,
                    offset: Offset(0, 6), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft : Radius.circular(10),
                        bottomLeft : Radius.circular(10),
                        bottomRight : Radius.circular(10),

                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height:60,
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: ListTile(
                            title: Text(widget.datumAllMyPosts.name??"",
                              style: AppTextStyle.ModernEra(
                                AppColors.blackColor,
                                14.sp,
                                FontWeight.w700,
                              ),
                            ),
                            subtitle: Text('${widget.datumAllMyPosts.totalMembers} members'??"",
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
                              widget.datumAllMyPosts.posts.length
                              , (index){
                                var postItem=widget.datumAllMyPosts.posts[index];
                            return
                              GestureDetector(
                                onTap: (){
                                  imagesPicP.clear();
                                  for(int i=0;i<postItem.images.length;i++){
                                    imagesPicP.add(
                                      ImagePicP(
                                          id: i,
                                          url: postItem.images[i].url,
                                          order: i,
                                      ),
                                    );
                                  }
                                  Get.to(PostView(model:
                                  Datum(
                                      id:postItem.id,
                                      isFlag:postItem.isFlag,
                                      isAnonymous:postItem.isAnonymous,
                                      isApproved:postItem.isApproved,
                                      flagDescription:postItem.flagDescription,
                                      flagCount:postItem.flagCount,
                                      description:postItem.description,
                                       userId:postItem.userId,
                                      groupId:postItem.groupId,
                                      createdAt:postItem.createdAt,
                                      updatedAt:postItem.updatedAt,
                                      avatar:postItem.avatar,
                                      images:imagesPicP,
                                      likesCounter:postItem.likesCounter,
                                      dislikesCounter:postItem.dislikesCounter,
                                      reactionType:postItem.reactionType,
                                      commentsCount:postItem.commentsCount,
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
                                  )
                                  ),);
                                },
                                child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: postItem.isAnonymous == 0
                                              ? CircleAvatar(
                                            backgroundImage: NetworkImage(authPro.userModel!.avatar),
                                            radius: 25,
                                          )
                                              : CircleAvatar(
                                            backgroundImage:
                                            NetworkImage(authPro.userModel!.blurredAvatar),
                                            radius: 25,
                                          ),
                                          title: postItem.isAnonymous == 0
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
                                            postItem.createdAt,
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
                                          postItem.description ?? "",
                                          style: AppTextStyle.ModernEra(
                                            AppColors.blackColor,
                                            12.sp,
                                            FontWeight.w500,
                                          ),
                                        ),



                                      //-----------------------------------------------------------------------
                                        //---------------------------------------------------------------------
                                        postItem.images.isNotEmpty
                                            ? postItem.images.length > 1
                                            ?
                                        //----Show Multiples Images---------
                                        Container(
                                          width: queryData.size.width,
                                          height: queryData.size.height * 0.5,
                                          margin: EdgeInsets.symmetric(vertical: 12),
                                          child: StaggeredGridView.countBuilder(
                                            physics: NeverScrollableScrollPhysics(),
                                            crossAxisCount: 3,
                                            itemCount: postItem.images.length >= 4
                                                ? 4
                                                : postItem.images.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              int maxImages = 4;
                                              int numImages = postItem.images.length;
                                              // Check how many more images are left
                                              int remaining = numImages - maxImages;
                                              String imageUrl = postItem.images[index].url;
                                              if (index == 0) {
                                                //====Gesture Dectector put here======
                                                return Container(
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
                                                );
                                              } else {
                                                print(
                                                    "---index:${index}----imageURL:${postItem.images.length}");
                                                if (index == 3 && numImages > 4) {
                                                  //Last Image
                                                  //====Gesture Dectector put here======
                                                  return Container(
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
                                                  );
                                                } else {
                                                  //====Gesture Dectector put here======

                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(20),
                                                        child: Image.network(imageUrl,
                                                            fit: BoxFit.cover)),
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
                                        //====Gesture Dectector put here======
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
                                              child: Image.network(postItem.images[0].url,
                                                  fit: BoxFit.cover),
                                            ))
                                            : SizedBox(
                                          height: queryData.size.height * 0.01,
                                        ),









                                        //-------------------------------------------------------------------------------------
                                        //-----Show Flag---------------------------------------
                                        postItem.isFlag == 1
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
                                                      postItem.flagCount??1,
                                                          (index){
                                                        return    Padding(
                                                          padding: EdgeInsets.only(right: 5),
                                                          child: Image.asset(AppImages.redFlag,width: queryData.size.width*0.05,height: queryData.size.height*0.04,),
                                                        );
                                                      }),
                                                ),
                                              ),
                                              Text(
                                                postItem.flagDescription ?? "",
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
                                      ],
                                    ),
                                  ),
                                  index ==
                                      widget.datumAllMyPosts.posts
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
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
  //---------------------------------------------------------------
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
}
