import 'package:carousel_slider/carousel_slider.dart';
import 'package:dateify_project/resources/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../resources/app_images.dart';
import '../../model/comment_model.dart';
import '../../model/post_model.dart';

class PictureView extends StatefulWidget {
  Datum? model;
  Comment? commentModel;
  int initialPage;
  bool commentImage;
  PictureView({Key? key,
    required this.initialPage,
    this.commentImage=false,
    this. model,
    this.commentModel,
  }) : super(key: key);

  @override
  State<PictureView> createState() => _PictureViewState();
}

class _PictureViewState extends State<PictureView> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greyColor,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Image.asset(AppImages.arrowback,height: 35,)),
        ),
      body: Container(
        color: AppColors.blackColor,
        child: CarouselSlider.builder(
          itemCount:widget.commentImage==true?widget.commentModel!.images.length:widget.model!.images.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
              Image.network(widget.commentImage==true?widget.commentModel!.images[itemIndex].url!:widget.model!.images[itemIndex].url,
                  fit: BoxFit.fitWidth,
                height: queryData.size.height,
              ),
          options: CarouselOptions(
            initialPage:widget.initialPage,
            enableInfiniteScroll: false,
            scrollPhysics:
            (widget.commentImage==true?
            (widget.commentModel!.images.length > 1)
                :(widget.model!.images.length > 1))
                ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
            height: queryData.size.height,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
          ),
        ),
      ),
    );
  }
}
