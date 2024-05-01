
import 'package:dateify_project/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../backend/api_request.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/text_styles.dart';
import '../src/auth/view_model/auth_vm.dart';
import '../src/base_screen/home/view_model/home_vm.dart';

class Helper {

  static ToastFlutter(String msg){
     Fluttertoast.showToast(
         msg: msg,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         fontSize: 16.0
     );
   }

  //-----------------------------------------------------------
  static blockUser(int userID) async {
    print('Repost Called in Comment');
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'user_id': '${userID}',
        },
        '/user/block',
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
  //------------Report Post------------------------------------
  static reportPost(int commentID) async {
    print('Repost Called in Comment');
    var token = await Helper.Token();
    Services.postApiWithHeaders(
        {
          'post_id': '${commentID}',
          'reason': 'null',
          'additional_note': 'null',
        },
        '/posts/report',
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
  //----------Delete Comment-----------------------------------
  static deletePost(int postID)async{
    print("--Post ID--${postID}");
    var token=await Helper.Token();
    Services.deleteApi(
        '/posts/delete?post_id=${postID}',
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
  //============================================================
  static showDialog(String title, String description, String btnOneText,
      Function()? onCancle, String btnTwoText, Function()? onTap2,BuildContext  context) {
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
      },
    );
  }




  // static Future  getCurrentLocation() async {
  //   Location location = Location();
  //   LocationData? currentPosition = await location.getLocation();
  //   List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(currentPosition.latitude!, currentPosition.longitude!);
  //   geo.Placemark placeMark = placemarks[0];
  //   return placeMark;
  //   // notifyListeners();
  // }


  /*
  * description: Show a message
  * input: a message string
  * output: a scaffold snackBar
  */
  static Future showSnackBar(String message, {bool isError = false}) async {
    return ScaffoldMessenger.of(Get.context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  /*
  * description: Change colors to material colors
  * input: Color
  * Output: material color
  */
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  static List<String> denydWords=
  [
    "arsehole",
    "asshole",
    "assmuncher",
    "assnigger",
    "asswipe",
    "assmonkey",
    "asshat",
    "bastard",
    "beaner",
    "beartrap",
    "bitch",
    "bitchass",
    "bitches",
    "bitchtits",
    "bimbo",
    "bollocks",
    "bollox",
    "bullshit",
    "brotherfucker",
    "bumblefucker",
    "buttfucka",
    "buttfucker",
    "camel toe",
    "carpet muncher",
    "chinc",
    "choad",
    "chode",
    "coochy",
    "coon",
    "cooter",
    "cracker",
    "damn",
    "dago",
    "deggo",
    "dipshit",
    "douche",
    "dyke",
    "fat",
    "fag",
    "faggit",
    "fuck",
    "gay",
    "gook",
    "gringo",
    "guido",
    "guinea",
    "heeb",
    "hell",
    "hillbilly",
    "ho",
    "hoe",
    "homo",
    "idiot",
    "jackass",
    "jap",
    "jerk",
    "jigaboo",
    "jizz",
    "junglebunny",
    "kike",
    "kooch",
    "kootch",
    "kraut",
    "kunt",
    "kyke",
    "lesbian",
    "lezzie",
    "lesbo",
    "mcfagget",
    "mick",
    "mothafucka",
    "motherfucker",
    "mothafuckin",
    "moron",
    "muffdriver",
    "nazi",
    "negro",
    "nigger",
    "nigga",
    "niglet",
    "nutsack",
    "nut sack",
    "paki",
    "piss",
    "pollock",
    "poonani",
    "poonany",
    "punany",
    "punani",
    "polesmoker",
    "porchmonkey",
    "puta",
    "punta",
    "puto",
    "queer",
    "retard",
    "red neck",
    "ruski",
    "rim",
    "sandnigger",
    "schlong",
    "scrote",
    "shit",
    "slut",
    "skank",
    "slut",
    "spic",
    "spick",
    "whore",
    "wanker",
    //===============================
    "aids",
    "anxiety",
    "anorexic",
    "anorexia",
    "bulimia",
    "bulimic",
    "attention deficit",
    "autism",
    "bipolar",
    "cancer",
    "chlamydia",
    "clap",
    "crabs",
    "corona",
    "covid",
    "disorder",
    "down syndrome",
    "depression",
    "ed",
    "genital herpes",
    "genital sore",
    "genital wart",
    "gonorrhea",
    "hepatitis",
    "hiv",
    "hsv-1",
    "hsv-2",
    "hpv",
    "lice",
    "mgen",
    "molluscum",
    "ngu",
    "pid",
    "pelvic inflammatory disease",
    "pubic lice",
    "ptsd",
    "post traumatic stress disorder",
    "paranoia",
    "psychosis",
    "syphilis",
    "scabies",
    "trichomoniasis",
    "ms",
    "schizophrenia",
    "schizophrenic",
    "schizo",
    "ocd",
    "obsessive compulsive",
    //==================
    "blow job",
    "boner",
    "bulge",
    "butt plug",
    "cock",
    "creampie",
    "clit",
    "clitoris",
    "circumcision",
    "cunt",
    "dick",
    "deep throat",
    "doggy style",
    "dildo",
    "edging",
    "fingering",
    "foot fetish",
    "foot job",
    "foreplay",
    "golden shower",
    "gagging",
    "gag reflex",
    "hand job",
    "labia",
    "lube",
    "masturbation",
    "mile high club",
    "milf",
    "missionary",
    "motorboating",
    "nipple",
    "oral",
    "orgy",
    "penis",
    "pecker",
    "pegging",
    "pussy",
    "quickie",
    "queefing",
    "rimming",
    "rim job",
    "squirting",
    "strap-on",
    "testicle",
    "tits",
    "twat",
    "tea bagging",
    "threesome",
    "vag",
    "vagina",
    "vajayjay",
    "va j j",
    "vibrator",
    "wank job",
    //==================
    "democrat",
    "republican",
    "liberal",
    "centre",
    "right wing",
    "left wing",
    "green party",
    "communist",
    "fascist",
    "zionist",
    "pelosi",
    "trump",
    "biden",
    "obama",
    "mohammed bin salman",
    "mbs",
    "putin",
    "xi jinping",
    "zelenskyy",
    "raisi",
    "khamenei",
    "ayatollah",
    "hitler",
    "kim jong-un",
    "cameltoe harris",
    "harris",
    "kissinger",
    "sleepy joe",
    "creepy joe",
    "war",
    "cia",
    "central intelligence agency"
  ];

  //==============================================
  static  Future<String?> Token() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

}
