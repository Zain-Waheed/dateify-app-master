// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class FBCollections {
//   static CollectionReference todos =
//       FirebaseFirestore.instance.collection("todos");
// }
//
// Future<QuerySnapshot<Object?>> fetchAllVideos() async{
//   var firestore=FirebaseFirestore.instance;
//   QuerySnapshot querySnapshot;
//   querySnapshot=await firestore.collection('AllVideos').get();
//   // AllVideosModel(doc: querySnapshot.da,link: '');
//   return querySnapshot;
// }
// Future<QuerySnapshot<Object?>> fetchPopularVideos() async{
//   var firestore=FirebaseFirestore.instance;
//   QuerySnapshot querySnapshot;
//   querySnapshot=await firestore.collection('PopularVideos').get();
//   // AllVideosModel(doc: querySnapshot.da,link: '');
//   log("*******************Zain ********************"+querySnapshot.docs.toString());
//   return querySnapshot;
// }
//
// Future<List<dynamic>>  fetchFavVideos() async{
//   List<dynamic> nested=[];
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? userPref =prefs.getString('user');
//   Map<String,dynamic> userMap = jsonDecode(userPref!) as Map<String, dynamic>;
//   String userId= userMap["doc"];
//   log("**************The User Id in fav Fetch is **************"+userId.toString());
//
//   FirebaseFirestore.instance
//       .collection('Users')
//       .doc(userId)
//       .get().then((DocumentSnapshot documentSnapshot) {
//          if(documentSnapshot.exists)
//          {
//            nested = documentSnapshot.get(FieldPath(['FavVideos']));
//            print('Fetched Favourite videos are *********: ${nested}');
//            print('The Value from list  *********: ${nested[0]["Title"]}');
//            return nested;
//            // try {
//            // } on StateError catch(e) {
//            //   print('No nested field exists!');
//            // }
//            // print('Fetched Value is*********: ${documentSnapshot.data()}');
//          }else
//            {
//              print('Document does not exist on the database');
//            }
//        },);
//        return nested;
//   // FirebaseFirestore.instance
//   //     .collection('Users')
//   //     .doc(userId)
//   //     .get('FavVideos').
//
//
//   // var firestore=FirebaseFirestore.instance;
//   // QuerySnapshot querySnapshot;
//   // querySnapshot=await firestore.collection('PopularVideos').get();
//   // AllVideosModel(doc: querySnapshot.da,link: '');
//   // return querySnapshot;
// }
//
//
//
//
//
//
//
// Future<void> addAllVideo(String link,String videoTitle,String videoDescription) async{
//   var firestore=FirebaseFirestore.instance;
//   var a =DateTime.now().millisecondsSinceEpoch.toString();
//   print('********************The All Video title  is *********************************:$videoTitle');
//   print('********************The All Video  Link is *********************************:$videoDescription');
//   var add=
//   {
//     'title':videoTitle,
//     'description':videoDescription,
//     'link':link,
//     'doc':a
//   };
//
//   await firestore.collection('AllVideos').doc(a).set(add);
//   print('********************The All Video  Link is *********************************:$link');
// }
// Future<void> addPopularVideo(String? link,String? videoTitle,String? videoDescription,String? doc) async{
//   var firestore=FirebaseFirestore.instance;
//   var a =DateTime.now().millisecondsSinceEpoch.toString();
//   print('********************The Popular Video title  is *********************************:$videoTitle');
//   print('********************The Popular Video  Link is *********************************:$videoDescription');
//   var add=
//   {
//     'title':videoTitle,
//     'description':videoDescription,
//     'link':link,
//     'doc':doc
//   };
//
//   await firestore.collection('PopularVideos').doc(a).set(add);
//   print('********************The Popular Video Link *********************************:$link');
// }
//
//
//
// Future<void> addCategoryVideo(String link,String videoTitle,String videoDescription,String? doc) async{
//   var firestore=FirebaseFirestore.instance;
//   var a =DateTime.now().millisecondsSinceEpoch.toString();
//   print('********************The Category Video title  is *********************************:$videoTitle');
//   print('********************The All Category Video  Link is *********************************:$videoDescription');
//   var add=
//   {
//     'title':videoTitle,
//     'description':videoDescription,
//     'link':link,
//     'doc':a
//   };
//
//   await firestore.collection('CategoryOne').doc(a).set(add);
//   print('********************The Category Video  Link is *********************************:$link');
// }