import 'package:dateify_project/localization/app_localization.dart';
import 'package:dateify_project/resources/app_colors.dart';
import 'package:dateify_project/resources/text_styles.dart';
import 'package:dateify_project/src/base_screen/search/view/search.dart';
import 'package:dateify_project/src/base_screen/search/view_model/search_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  List<String> options = ['Global search', 'Groups you joined'];
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Consumer<SearchVM>(builder: (context,searchPro,_){
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            leading: TextButton(
              onPressed: (){
                Get.back();
              },
              child: Text(getTranslated(context, 'cancel')??"",
                style: AppTextStyle.ModernEra(
                  AppColors.blackColor,
                  14.sp,
                  FontWeight.w400,
                ),
              ),
            ),
            leadingWidth: 100,
            centerTitle: true,
            elevation: 0,
            backgroundColor:AppColors.lightGreyColor ,
            title: Text(getTranslated(context, 'search_filters')??"",
              style: AppTextStyle.ModernEra(
                AppColors.blackColor,
                20.sp,
                FontWeight.w700,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Get.bottomSheet(GroupSelectionBottomSheet());
                    // if(formKey.currentState!.validate()){
                    //   requestPost();
                    // }
                    if(searchPro.selectedOption=="Global search"){
                      searchPro.searchOption="1";
                      Get.back();
                    }else
                    {
                      searchPro.searchOption="0";
                      searchPro.update();
                      Get.back();
                    }
                    //------------------------
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainPurpleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    getTranslated(
                      context,
                      'apply',
                    ) ??
                        "",
                    style: AppTextStyle.ModernEra(
                      AppColors.whiteColor,
                      12.sp,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: queryData.size.width,
          height: queryData.size.height,
          color: AppColors.lightGreyColor,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslated(context, 'groups')??"",
                  style: AppTextStyle.ModernEra(
                    AppColors.blackColor,
                    18.sp,
                    FontWeight.w500,
                  ),
                ),
                Column(
                  children: options.map((option) {
                    return RadioListTile(
                      selected: true,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(option,style: AppTextStyle.ModernEra(
                        AppColors.blackColor,
                        13.sp,
                        FontWeight.w500,
                      ),),
                      value: option,
                      groupValue:searchPro.selectedOption,
                      onChanged: (value) {
                        setState(() {
                          searchPro.selectedOption = value!;
                        });
                        print("Search Option--${searchPro.searchOption}");
                      },
                      activeColor: AppColors.mainPurpleColor, // Set the color of the selected dot
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
}
