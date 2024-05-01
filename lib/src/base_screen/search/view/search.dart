import 'dart:convert';

import 'package:dateify_project/src/auth/view/singup/personel_info.dart';
import 'package:dateify_project/src/base_screen/home/view/home.dart';
import 'package:dateify_project/src/base_screen/search/model/search_model.dart';
import 'package:dateify_project/src/base_screen/search/view/search_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:http/http.dart' as http;

import '../../home/widget/search_group_widget.dart';
import '../view_model/search_vm.dart';
import '../widgets/search_group_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchController = TextEditingController();
  bool isIconVisible = false;
  bool hidePassword = false;
//=====Search Varaibles===========================
  final searchController = ScrollController();
  List<DatumSearch> searchitems = [];
  bool hasMoreSearch = false;
  int searchPage = 1;
  bool isLoadingSearch = false;
  //===============================================
  late String searchTermVal;
  //================================================
  List<String> options = ['Global search', 'Groups you joined'];
  //==============
  bool isFilterPage=true;
  @override
  void initState() {
    //==========================
    searchController.addListener(() {
      if (searchController.position.maxScrollExtent == searchController.offset) {
        String val=_searchController.text;
        print("---Search Page-----${searchPage}");
        if(searchPage!=1){
          fetchSearchItems(val);
        }
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    bool isJoinedTextShown = false;
    bool isNotJoinedTextShown = false;
    return Consumer<SearchVM>(builder: (context,searchPro,_){
      return Scaffold(
        appBar:isFilterPage?PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(top: 14.0, left: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(const HomeView());
                      },
                      child: Image.asset(
                        AppImages.arrowback,
                        width: queryData.size.width * 0.07,
                        height: queryData.size.height * 0.05,
                      )),
                  Text(
                    getTranslated(context, 'search') ?? "",
                    style: AppTextStyle.ModernEra(
                      AppColors.blackColor,
                      20.sp,
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            leadingWidth: 300,
          ),
        ):
            //-----Filter Page
        PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            leading: TextButton(
              onPressed: (){
                // Get.back();
                setState(() {
                  isFilterPage=true;
                });
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
                      // Get.back();
                      setState(() {
                        isFilterPage=true;
                      });
                    }else
                    {
                      searchPro.searchOption="0";
                      searchPro.update();
                      // Get.back();
                      setState(() {
                        isFilterPage=true;
                      });
                    }
                    searchitems.clear();
                    String val=_searchController.text;
                    fetchSearchItems(val);
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
        body:isFilterPage?
        Container(
          height: queryData.size.height,
          color: AppColors.lightGreyColor,
          child: Column(
            children: [
              Container(
                color: AppColors.whiteColor,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: queryData.size.width * 0.03,
                        ),
                        Container(
                          width: queryData.size.width * 0.82,
                          height: queryData.size.height * 0.05,
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: TextFormField(
                              controller: _searchController,
                              decoration: AppInputDecoration.searchFieldDecorationSmall(
                                Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(AppImages.serarchPruple,
                                        width: queryData.size.width * 0.04,
                                        height: queryData.size.height * 0.02)),
                                'search',
                                isIconVisible
                                    ? IconButton(
                                  icon: Image.asset(
                                    AppImages.cross,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      isIconVisible = false;
                                      //=====================
                                      searchitems.clear();
                                    });
                                  },
                                )
                                    : null,
                              ),
                              onChanged: (value) {
                                value.isNotEmpty
                                    ? setState(() => isIconVisible = true)
                                    : setState(() => isIconVisible = false);
                                //or
                                setState(() => value.isNotEmpty
                                    ? isIconVisible = true
                                    : isIconVisible = false);
                                final searchTerm = value.trim();
                                fetchSearchItems(searchTerm);
                                setState(() {
                                  searchTermVal=searchTerm;
                                });
                              }),
                        ),
                        IconButton(
                            onPressed: () {
                              // Get.to(SearchFilter());
                              setState(() {
                                isFilterPage=false;
                              });
                            },
                            icon: Image.asset(
                              AppImages.filterGroup,
                              width: queryData.size.width * 0.08,
                              height: queryData.size.height * 0.08,
                            )),
                      ],
                    ),
                    //=======Serach Body===============================
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              // if (isLoadingSearch)
              //   const Center(
              //     child: CircularProgressIndicator(),
              //   )
              // else
              Expanded(
                child: ListView.builder(
                  controller: searchController,
                  itemCount: searchitems.length + 1,
                  itemBuilder: (context, index) {
                    if (index < searchitems.length) {
                      final itemGroups = searchitems[index];
                      if (itemGroups.isMember==true && !isJoinedTextShown)
                      {
                        isJoinedTextShown = true;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 15,bottom: 10),
                            child: Text(
                            "Your Groups",
                            style: AppTextStyle.ModernEra(
                              AppColors.darkGreyColor,
                              12.sp,
                              FontWeight.w400,
                            ),
                        ),
                          ),
                        SearchWidget(
                          datumGroups: itemGroups,
                        ),
                          ],
                        );
                      }
                      else
                      if (itemGroups.isMember==false && !isNotJoinedTextShown)
                        {
                          isNotJoinedTextShown = true;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20,top: 15,bottom: 10),
                                child: Text(
                                  "Global search",
                                  style: AppTextStyle.ModernEra(
                                    AppColors.darkGreyColor,
                                    12.sp,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              SearchWidget(
                                datumGroups: itemGroups,
                              ),
                            ],
                          );
                        } else
                        {
                         return SearchWidget(
                            datumGroups: itemGroups,
                          );
                        }
                      // PostSectionWidget(datumAllMyPosts: itemPosts,);
                    }
                    else {
                      isNotJoinedTextShown = true;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: hasMoreSearch
                              ? CircularProgressIndicator()
                              :searchitems.isNotEmpty ?const Text('No more search results matched'):SizedBox(),
                        ),
                      );
                    }
                  },),
              ),
            ],
          ),
        ):
        //====Filter Page
        Container(
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
    });
  }

  //==========Fetch Groups=================
 void  fetchSearchItems(String searchTerm) async {
    print("---Fetch Search Item Called----${searchTerm}");
    if (searchTerm.isEmpty){
      searchitems.clear();
      setState(() {
        hasMoreSearch=false;
      });
      return;
    }
    setState(() {
      hasMoreSearch=true;
    });
    // if (isLoadingSearch) return;
    isLoadingSearch = true;
    var searchPro = Provider.of<SearchVM>(context, listen: false);
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Helper.ToastFlutter('No Internet Connection');
      } else {
        final url = Uri.parse(
            'https://api.dateifyapp.com/api/v1/groups/search?name=${searchTerm}&is_global=${searchPro.searchOption}&page=${searchPage}');
        var token = await Helper.Token();
        // final url=Uri.parse('http://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
        final response = await http.get(url, headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        });
        print("${response.body}");
        if (response.statusCode == 200) {
          SearchModel searchModel =
              SearchModel.fromJson(jsonDecode(response.body));
          // final List newItems = allMyPostsModel.content.posts.data;
          setState(() {
            if (searchModel.content.groups.nextPageUrl != null) {
              searchPage++;
              isLoadingSearch = false;
            } else {
              searchPage = 1;
              isLoadingSearch = false;
              setState(() {
                hasMoreSearch=false;
              });
            }
            searchitems.addAll(searchModel.content.groups.data);
            //-----------------------------------------------------------------------------------------
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print("*****Search API****eeeeeeeee**${e}");
    }
  }
}

//-----------------------------------------