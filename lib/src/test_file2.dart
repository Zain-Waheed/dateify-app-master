import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainPage2 extends StatefulWidget {
  const MainPage2({Key? key}) : super(key: key);

  @override
  State<MainPage2> createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
  final controller=ScrollController();
  List<String> items=[];
  bool hasMore=true;
  int page=1;
  bool isLoading=false;
  @override
  void initState() {
    fetch();
    controller.addListener(() {
      if(controller.position.maxScrollExtent==controller.offset){
        fetch();
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  Future fetch()async{
    if(isLoading) return;
    isLoading=true;
    const limit=20;
    final url=Uri.parse('http://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
    final response=await http.get(url);
    if(response.statusCode==200){
      final List newItems=json.decode(response.body);
      setState(() {
        page++;
        isLoading=false;
        if(newItems.length<limit){
          hasMore=false;
        }
        items=newItems.map<String>((item){
          final number=item['id'];
          return 'Item $number';
        }).toList();
      });
    }
  }
  Future refresh()async{
    setState(() {
      isLoading=false;
      hasMore=true;
      page=0;
      items.clear();
    });
    fetch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull to refresh'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          controller: controller,
          padding: const EdgeInsets.all(8),
            itemCount: items.length+1,
            itemBuilder: (context,index){
              if(index<items.length){
                final item=items[index];
                return  ListTile(title: Text(item));
              }else
                {
                  return  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child:hasMore? const CircularProgressIndicator():const Text('No More data to load'),
                    ),
                  );
                }
            }
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
// class StaggeredGridViewExample extends StatelessWidget {
//   final List<String> items = List.generate(20, (index) => 'Item $index');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Staggered Grid View Example'),
//       ),
//       body: StaggeredGridView.countBuilder(
//         crossAxisCount: 3,
//         itemCount: items.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             color: Colors.green,
//             child: Center(
//               child: Text(
//                 items[index],
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           );
//         },
//         staggeredTileBuilder: (int index) {
//           return StaggeredTile.count(1, 1);
//         },
//         mainAxisSpacing: 8.0,
//         crossAxisSpacing: 8.0,
//       ),
//     );
//   }
// }









