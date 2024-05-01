// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   List<String> items=['Items 1','Items 2','Items 3'];
//   Future refresh()async{
//     setState(() {
//       items.clear();
//     });
//     final url=Uri.parse('http://jsonplaceholder.typicode.com/posts');
//     final response=await http.get(url);
//     if(response.statusCode==200){
//       final List newItems=json.decode(response.body);
//       setState(() {
//         items=newItems.map<String>((item){
//           final number=item['id'];
//           return 'Item $number';
//         }).toList();
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pull to refresh'),
//       ),
//       body:  items.isEmpty?
//       const Center(
//         child: CircularProgressIndicator(),
//       )
//           :RefreshIndicator(
//         onRefresh: refresh,
//         child: ListView.builder(
//           itemCount: items.length,
//             itemBuilder: (context,index){
//               final item=items[index];
//               return  ListTile(title: Text(item));
//             }
//         ),
//       ),
//     );
//   }
// }


//================================================
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
// class StaggeredGridExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Staggered Grid View Example'),
//       ),
//       body: StaggeredGridView.count(
//         crossAxisCount: 3,
//         staggeredTiles: [
//           StaggeredTile.count(3, 3),
//           StaggeredTile.count(1, 1),
//           StaggeredTile.count(1, 1),
//           StaggeredTile.count(1, 1),
//         ],
//         children: [
//           Container(
//             color: Colors.green,
//             child: Center(
//               child: Text(
//                 'Big Item',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.blue,
//             child: Center(
//               child: Text(
//                 'Item 1',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.orange,
//             child: Center(
//               child: Text(
//                 'Item 2',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.purple,
//             child: Center(
//               child: Text(
//                 'Item 3',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


//=================================================



import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../resources/app_colors.dart';

class StaggeredGridViewExample extends StatelessWidget {
  List<String> imageUrls=[
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staggered Grid View Example'),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          int maxImages=4;
          int numImages = imageUrls.length;
          // Check how many more images are left
          int remaining = numImages -maxImages ;
          String imageUrl = imageUrls[index];
          if (index == 0) {
            return Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
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
            print("---index:${index}----imageURL:${imageUrls.length}");
            if(index==3){
              //Last Image
              return  Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(imageUrl, fit: BoxFit.cover)),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.blackColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+'+remaining.toString(),
                        style: TextStyle(fontSize: 32,color:AppColors.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            );
            }else
              {
                return  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(imageUrl, fit: BoxFit.cover)),
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
    );
  }
}

