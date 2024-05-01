
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dateify_project/utils/helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../src/base_screen/home/model/post_model.dart';
import 'base_url.dart';

class Services {
  static const String   baseURL='https://api.dateifyapp.com/api/v1';
  Future post(
      {var url,
        dynamic body,
        dynamic header,
        Function(Map)? onSuccess,
        Function(Map)? onError}) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        return false;
      }
      print("this is url: $url");
      print("this is header: ${header ?? MyHeaders.header()}");
      print("this is body: $body");
      var response = await http
          .post(Uri.parse(url),
          headers: header ?? MyHeaders.header(), body: body)
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw Exception("Request Time Out");
      });
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        onSuccess!(jsonDecode(response.body));
      } else {
        onError!(jsonDecode(response.body));
      }
    } catch (e) {
      onError!(jsonDecode(e.toString()));
    }
  }
  //==============================================================
  //==============================================================
  static Future postApi(Map<String,dynamic> prams,String url) async {
    try{
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Fluttertoast.showToast(
            msg: 'No Internet Connection',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0
        );
        return false;
      }
      print("this is body: $prams");
      final response = await http.post(
        Uri.parse(baseURL+url),
        body: prams,
      );
      print("**Response Body***${response.body}");
      if (response.statusCode==200) {
        return jsonDecode(response.body);
      }else
        {
          return jsonDecode(response.body);
        }
    }catch(e){
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
      );
      print( "*****   Post API****eeeeeeeee**${e}");
    }

  }
  //==============================================================
  //==============================================================
  static Future postApiWithHeaders(Map<String,dynamic>? prams,String url,Map<String, String>? headers) async {
    try{
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Fluttertoast.showToast(
            msg: 'No Internet Connection',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0
        );
        return false;
      }
      print("this is body: $prams");
      final response = await http.post(
        Uri.parse(baseURL+url),
        body: prams,
        headers: headers
      );
      print("**Response Body***${response.body}");
      if (response.statusCode==200) {
        return jsonDecode(response.body);
      }else
      {
        return jsonDecode(response.body);
      }
    }catch(e){
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
      );
      print( "*****  Post API with Headers****eeeeeeeee**${e}");
    }

  }

  //==============================================================
  //==============================================================
  static Future deleteApi(String url,Map<String, String>? headers) async {
    try{
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Fluttertoast.showToast(
            msg: 'No Internet Connection',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0
        );
        return false;
      }
      final response = await http.delete(
          Uri.parse(baseURL+url),
          headers: headers
      );
      print("**Response Body***${response.body}");
      if (response.statusCode==200) {
        return jsonDecode(response.body);
      }else
      {
        return jsonDecode(response.body);
      }
    }catch(e){
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
      );
      print( "*****  Post API with Headers for delete****eeeeeeeee**${e}");
    }

  }
  //==============================================================
  //==============================================================
  static Future postRegister(Map<String,dynamic> prams,PlatformFile pickedFile,String url) async {
    try{
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
       Helper.ToastFlutter('No Internet Connection');
       return false;
      }
      var URL = Uri.parse(baseURL+url);
      var file = File(pickedFile.path!);
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile('photo', stream, length,
          filename: file.path.split('/').last);

      var request = http.MultipartRequest('POST', URL);
      request.fields['name'] = prams['name'];
      request.fields['username'] = prams['username'];
      request.fields['dob'] = prams['dob'];
      request.fields['gender'] = prams['gender'];
      request.fields['phone'] = prams['phone'];
      request.files.add(multipartFile);

      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      // print(responseString);


      print("**Response Body***${responseString}");
      if (response.statusCode==200) {
        return jsonDecode(responseString);
      }else
      {
        return jsonDecode(responseString);
      }
    }catch(e){
      Helper.ToastFlutter(e.toString());
      print( "*********eeeeeeeee  Post Register API **${e}");
    }

  }


//==============================================================
//==============================================================

  static Future newPost(Map<String,dynamic> prams,List<File> files,String url,Map<String, String> headers) async {
    try{
      print("this is body: $prams");
      print("this is headers:  ${headers}");
      var URL = Uri.parse(baseURL+url);
      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(
        headers,
      );
      request.fields['is_flag'] = prams['is_flag'];
      request.fields['is_anonymous'] = prams['is_anonymous'];
      request.fields['flag_description'] = prams['flag_description'];
      request.fields['flag_count'] = prams['flag_count'];
      request.fields['description'] = prams['description'];
      request.fields['group_id'] = prams['group_id'];
      files.asMap().forEach((i, img) async {
        request.files
            .add(await http.MultipartFile.fromPath("images[$i]", img.path));
        print("********Files are added  in the screen*****************");
      });
      print(request.files.length);
      bool isConnected = await checkInternet();
      if (isConnected) {
        http.StreamedResponse response = await request.send().timeout(
          Duration(minutes: 1),
        );
        print(response.statusCode);

        final responseBody = await response.stream.bytesToString();

        Map jsonResponse = jsonDecode(responseBody);
        print(jsonResponse);
        if (response.statusCode==200) {
          return jsonDecode(responseBody);
        } else {
          return jsonDecode(responseBody);
        }
      }
    } catch (e) {
      Helper.ToastFlutter(e.toString());
      print( "*********eeeeeeeee  New Post **${e}");
    }
  }
  //==============================================================
//==============================================================
  static Future addComment(Map<String,dynamic> prams,List<File> files,String url,Map<String, String> headers) async {
    try{
      print("this is body: $prams");
      print("this is headers:  ${headers}");
      var URL = Uri.parse(baseURL+url);
      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(
        headers,
      );
      request.fields['body'] = prams['body'];
      request.fields['post_id'] = prams['post_id'];
      request.fields['parent_comment_id'] = prams['parent_comment_id'];
      request.fields['is_anonymous'] = prams['is_anonymous'];
      files.asMap().forEach((i, img) async {
        request.files
            .add(await http.MultipartFile.fromPath("images[$i]", img.path));
        print("********Files are added  in the screen*****************");
      });
      print(request.files.length);
      bool isConnected = await checkInternet();
      if (isConnected) {
        http.StreamedResponse response = await request.send().timeout(
          Duration(minutes: 1),
        );
        print(response.statusCode);

        final responseBody = await response.stream.bytesToString();

        Map jsonResponse = jsonDecode(responseBody);
        print(jsonResponse);
        if (response.statusCode==200) {
          return jsonDecode(responseBody);
        } else {
          return jsonDecode(responseBody);
        }
      }
    } catch (e) {
      Helper.ToastFlutter(e.toString());
      print( "****Add Comment*****eeeeeeeee**${e}");
    }
  }
  //==============================================================
//==============================================================

  static Future getApi(Map<String, String>? headers,String url) async {

    try{
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Helper.ToastFlutter('No Internet Connection');
        return false;
      }
      final response = await http.get(
          Uri.parse(baseURL+url),
          headers:  headers
      );
      print("**Response Body***${response.body}");
      if (response.statusCode==200) {
        return jsonDecode(response.body);
      }else
      {
        return jsonDecode(response.body);
      }
    } catch(e){
    Helper.ToastFlutter(e.toString());
    print( "******Get API***eeeeeeeee**${e}");
    }


  }
  //-------------------------------------------------------------------------
  //-------------------------------------------------------------------------
  static Future contactUsPost(Map<String,dynamic> prams,List<File> files,String url,Map<String, String> headers) async
  {
    try{
      print("this is body: $prams");
      print("this is headers:  ${headers}");
      var URL = Uri.parse(baseURL+url);
      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(
        headers,
      );
      request.fields['email'] = prams['email'];
      request.fields['message'] = prams['message'];
      files.asMap().forEach((i, img) async {
        request.files
            .add(await http.MultipartFile.fromPath("images[$i]", img.path));
        print("********Files are added  in the screen*****************");
      });
      print(request.files.length);
      bool isConnected = await checkInternet();
      if (isConnected) {
        http.StreamedResponse response = await request.send().timeout(
          Duration(minutes: 1),
        );
        print(response.statusCode);

        final responseBody = await response.stream.bytesToString();

        Map jsonResponse = jsonDecode(responseBody);
        print(jsonResponse);
        if (response.statusCode==200) {
          return jsonDecode(responseBody);
        } else {
          return jsonDecode(responseBody);
        }
      }
    } catch (e) {
      Helper.ToastFlutter(e.toString());
      print( "*********eeeeeeeee Contact Us API **${e}");
    }
  }
//==============================================================
//==============================================================
  static Future postEditProfile(Map<String,dynamic> prams,PlatformFile pickedFile,Map<String, String> headers,String url) async {
    try{
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Helper.ToastFlutter('No Internet Connection');
      }
      var URL = Uri.parse(baseURL+url);
      var file = File(pickedFile.path!);
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: file.path.split('/').last);

      var request = http.MultipartRequest('POST', URL);
      request.fields['name'] = prams['name'];
      request.fields['username'] = prams['username'];
      request.files.add(multipartFile);
      //----------------------------------
      request.headers.addAll(headers);
      //----------------------------------
      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      // print(responseString);


      print("**Response Body***${responseString}");
      if (response.statusCode==200) {
        return jsonDecode(responseString);
      }else
      {
        return jsonDecode(responseString);
      }
    }catch(e){
      Helper.ToastFlutter(e.toString());
      print( "*********eeeeeeeee  Post EDIT Profile API **${e}");
    }

  }
}

  Future<bool> checkInternet() async {

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }else{
        return false;
      }
    }catch (_) {
      print('not connected');
      return false;
    }

  }

class MyHeaders {
  static Map<String, String> header() {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer 5|lOE0g9YJObGyDm1VmLzqcA0xojRF2hKl3nHglNSs',
    };
  }}