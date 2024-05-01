import 'dart:io';

import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/src/auth/view/singup/personel_info.dart';
import 'package:dateify_project/src/base_screen/home/view/home.dart';
import 'package:dateify_project/src/base_screen/home/view_model/home_vm.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../backend/api_request.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_images.dart';
import '../../../../resources/input.decorations.dart';
import '../../../../resources/text_styles.dart';
import '../../../../utils/helper.dart';
import '../../../auth/view_model/auth_vm.dart';
import '../../../test_file.dart';
import '../model/comment_model.dart';
import '../model/post_model.dart';
import '../widget/commnets_widget.dart';
import '../widget/post_view_widget.dart';
import '../widget/post_widget.dart';

class PostView extends StatefulWidget {
  Datum model;
  PostView({Key? key, required this.model}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _showSend = false;
  bool isLoading = false;
  bool hasMore = true;
  bool isComment=false;
  TextEditingController commentController = TextEditingController();
 late String commetText;
  void initState() {
    //---Controller Check----------
    commentController.addListener(_onTextChanged);
    //-----------------------------
    fetchCommnets(widget.model.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showSend = commentController.text.isNotEmpty;
    });
  }

  //----------------------------------------
  List<Comment> comments = [];
  List<ImagePicC> imagesPicC = [];
  //----------------------------------------
  //=====================================================================================
 late int postID;
  int? parentCommentID;
  List<File> images = [];
  List<File> imgesOnSend=[];
  //-------------------------------------------
  int? commmentIndex;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    //----Check that keyboard is open or not---------
    return Consumer2<HomeVM,AuthVM>(builder: (context, homePro,authPro, _) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: AppColors.whiteColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(5),
              ),
            ),
            leadingWidth: 100,
            leading: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Get.back();
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 14.0,bottom: 14),
                      child: Image.asset(AppImages.arrowback,)),
                  Text(
                    getTranslated(context, 'post') ?? "",
                    style: AppTextStyle.ModernEra(
                      AppColors.blackColor,
                      20.sp,
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0,
            centerTitle: false,
          ),
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: AppColors.lightGreyColor,
            width: queryData.size.width,
            height: queryData.size.height,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PostViewWidget(
                          model: widget.model,
                        ),
                        Column(
                          children: List.generate(comments.length + 1, (index) {
                            if (index < comments.length) {
                              return CommentsWidget(
                                commnetModel: comments[index],
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: Center(
                                  child: hasMore
                                      ? const CircularProgressIndicator()
                                      : isComment==true?
                                  LoadingAnimationWidget.waveDots(
                                    color: AppColors.mainPurpleColor,
                                    size: 50,
                                  ): Text('No More Comments'),
                                ),
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          color: AppColors.whiteColor,
                          width: _showSend
                              ? queryData.size.width * 0.85
                              : queryData.size.width,
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
                                focusNode: homePro.focusNode,
                                decoration:
                                    AppInputDecoration.circularFieldDecoration(
                                  GestureDetector(
                                    onTap: () {
                                      _pickImages(homePro);
                                    },
                                    child: SizedBox(
                                        width: queryData.size.width * 0.05,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Image.asset(
                                              AppImages.uploadingImg),
                                        )),
                                  ),
                                  'add_comment',
                                  null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    commentController.text = value;
                                  });
                                }),
                          ),
                        ),
                        // Container(
                        //   color: AppColors.whiteColor,
                        //   width: queryData.size.width*0.85,
                        //   height: queryData.size.height*0.065,
                        //   alignment: Alignment.center,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(40),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: AppColors.greyColor,
                        //           spreadRadius: -1,
                        //           blurRadius: 1,
                        //           offset: Offset(0, 6), // changes position of shadow
                        //         ),
                        //       ],
                        //     ),
                        //     margin: EdgeInsets.symmetric(horizontal: 15),
                        //     child: TextFormField(
                        //       controller: commentController,
                        //       cursorColor: AppColors.mainPurpleColor,
                        //       autovalidateMode: AutovalidateMode.onUserInteraction,
                        //       keyboardType: TextInputType.name,
                        //       textInputAction: TextInputAction.done,
                        //       // validator: (value) => FieldValidator.validateEmail(commentController.text),
                        //       decoration: AppInputDecoration.circularFieldDecoration(
                        //         Container(
                        //             width: queryData.size.width*0.05,
                        //             child: Image.asset(AppImages.uploadingImg)),
                        //         'add_comment',
                        //         null,
                        //       ),
                        //       onTap: (){
                        //
                        //       },
                        //       onChanged: (value){
                        //         setState(() {
                        //           commentController.text=value;
                        //         });
                        //       },
                        //     ),
                        //   ),
                        // ),
                        Visibility(
                          visible: _showSend,
                          child: GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              for(int i=0;i<images.length;i++){
                                imagesPicC.add(
                                  ImagePicC(
                                      id: i,
                                      filePath: images[i],
                                      order: i
                                  ),
                                );
                              }
                              print("**The value is not null*****:${homePro.parentCommentID}");
                              if(homePro.parentCommentID!=null)
                              {
                                commmentIndex=comments.indexOf(homePro.comment);
                                print("--------Replies index is------$commmentIndex");
                                //------------------------------------------------------------------------------
                                //Add Dummy Comment on Replies
                                setState(() {
                                  comments[commmentIndex!].childrenComments!.add(Comment(
                                    id: 1,
                                    body: commentController.text,
                                    postId: widget.model.id,
                                    userId: widget.model.userId,
                                    createdAt: widget.model.createdAt,
                                    updatedAt: widget.model.updatedAt,
                                    user: UserC(
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
                                    childrenComments: [],
                                    isAnonymous: homePro.isAnonymous == true ? 1 : 0,
                                    images:imagesPicC,
                                    likesCounter: 0,
                                    dislikesCounter: 0,
                                  ));
                                });
                                //===============================================================================
                              }else
                                {
                                  //------------------------------------------------------------------------------
                                  //Add Dummy Comment
                                  setState(() {
                                    comments.add(
                                      Comment(
                                        id: 1,
                                        body: commentController.text,
                                        postId: widget.model.id,
                                        userId: widget.model.userId,
                                        createdAt: widget.model.createdAt,
                                        updatedAt: widget.model.updatedAt,
                                        user: UserC(
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
                                        childrenComments: [],
                                        isAnonymous: homePro.isAnonymous == true ? 1 : 0,
                                        images:imagesPicC,
                                        likesCounter: 0,
                                        dislikesCounter: 0,
                                      ),
                                    );
                                  });
                                  //===============================================================================
                                }
                              //Add Values for original comments
                              homePro.postID = widget.model.id;
                              homePro.update();
                              commetText=commentController.text;
                              //----------------------------------------
                              setState(() {
                                imgesOnSend.addAll(images);
                                commentController.text="";
                              });
                              //-----------------------------------------
                              postID=homePro.postID!;
                              parentCommentID=homePro.parentCommentID;
                              images.clear();
                              homePro.update();
                              //--------------------------
                              //Hit API
                              addComment(homePro);
                            },
                            child: Image.asset(
                              AppImages.msgBtn,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _showSend == false
                        ? const SizedBox(
                            height: 20,
                          )
                        : const SizedBox(),
                    Visibility(
                      visible: _showSend,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Checkbox(
                            value: homePro.isAnonymous,
                            activeColor: AppColors.mainPurpleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                homePro.isAnonymous = value!;
                              });
                            },
                          ),
                          Text(
                            getTranslated(context, 'post_anonymously') ?? "",
                            style: AppTextStyle.ModernEra(
                              AppColors.blackColor,
                              12.sp,
                              FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //==========Grid View=======
                   images.isNotEmpty
                        ? Container(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.15,
                            child: SingleChildScrollView(
                              // Wrap GridView inside SingleChildScrollView
                              scrollDirection: Axis
                                  .horizontal, // Set scroll direction to horizontal
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < images.length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              images[i],
                                              width:
                                                  100, // Set width of each widget
                                              height:
                                                  100, // Set height of each widget
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () =>
                                                    _removeImage(i, homePro),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  padding: const EdgeInsets.all(4),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    //==========================
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
  void fetchCommnets(int postId) async {
    setState(() {
      isLoading = true;
    });
    var token = await Helper.Token();
    Services.getApi({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
    }, '/posts/comments?post_id=${postId}')
        .then((response) {
          if(mounted){
            setState(() {
              isLoading = false;
              hasMore = false;
            });
          }
      final data = response;
      if (data["success"] == true) {
        CommentModel commnetModel = CommentModel.fromJson(response);
        comments.addAll(commnetModel.content.comments);
      } else {
        Helper.ToastFlutter(data["description"]);
      }
    });
  }
//-------------------------------------------------------------------------------
  //========Pick Images==========================================================
  Future<void> _pickImages(HomeVM homePro) async {
    final pickedFiles = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    images.clear();
    homePro.update();
    if (pickedFiles != null) {
      setState(() {
        images.addAll(pickedFiles.paths.map((path) => File(path!)));
      });
    }
  }
  //========Remove Images======================================
  void _removeImage(int index, HomeVM homePro) {
    setState(() {
      images.removeAt(index);
    });
    homePro.update();
  }
  //-----------------------------------------------------------
  void addComment(HomeVM homePro) async {
    //-----------------------------------------------------------
    print("Post ID   :${postID}");
    print("Commnet Parent ID   :${parentCommentID}");
    print("imagesOnSned  :${imgesOnSend}");
    print("commetText :${commetText}");
    //-----------------------------------------------------------
    setState(() {
      isComment=true;
    });
    var token = await Helper.Token();
    Services.addComment(
        {
          "body": commetText,
          "post_id": "${homePro.postID}",
          "parent_comment_id": homePro.parentCommentID==null? "":"${homePro.parentCommentID}",
          "is_anonymous": homePro.isAnonymous == true ? "1" : "0",
        },
        imgesOnSend,
        "/posts/comments/create",
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }).then((value) {
      setState(() {
        isComment=false;
      });
      final data = value;
      final match = data["success"];
      if (match == true) {
        Helper.ToastFlutter(data["description"]);
      } else {
        Helper.ToastFlutter(data["description"]);
      }
    });
  }
  //==================================================================================
  //==================================================================================
}
