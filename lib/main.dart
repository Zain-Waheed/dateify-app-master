import 'package:dateify_project/resources/app_colors.dart';
import 'package:dateify_project/src/auth/view/signin/signin.dart';
import 'package:dateify_project/src/auth/view/singup/personel_info.dart';
import 'package:dateify_project/src/auth/view/singup/phone_view.dart';
import 'package:dateify_project/src/auth/view/singup/read_rules.dart';
import 'package:dateify_project/src/auth/view/singup/rules.dart';
import 'package:dateify_project/src/auth/view/singup/verification_approved.dart';
import 'package:dateify_project/src/auth/view_model/auth_vm.dart';
import 'package:dateify_project/src/base_screen/home/view/home.dart';
import 'package:dateify_project/src/base_screen/home/view_model/home_vm.dart';
import 'package:dateify_project/src/base_screen/search/view_model/search_vm.dart';
import 'package:dateify_project/src/base_screen/settings/view/settings.dart';
import 'package:dateify_project/src/base_screen/settings/view_model/setting_vm.dart';
import 'package:dateify_project/src/landing_pages/view/onboarding.dart';
import 'package:dateify_project/src/landing_pages/view/splash.dart';
import 'package:dateify_project/src/test_file.dart';
import 'package:dateify_project/src/test_file3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'localization/app_localization.dart';
import 'src/base_screen/base_vm.dart';
import 'package:sizer/sizer.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MultiProvider  (
      providers: [
        // ChangeNotifierProvider(create: (context) => TodoVM()),
        ChangeNotifierProvider(create: (context) => BaseVM()),
        ChangeNotifierProvider(create: (context) => AuthVM()),
        ChangeNotifierProvider(create: (context) => HomeVM()),
        ChangeNotifierProvider(create: (context) => SettingVM()),
        ChangeNotifierProvider(create: (context) => SearchVM()),
      ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context,Locale newLocale){
    _MyAppState? state=context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies() {
    setState((){
      // _locale=locale;
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  void initState() {

    // readPrefs();
    // _loadSharedData();
    setLocale(const Locale("en"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return
      Sizer(
          builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              locale: _locale,
              fallbackLocale: const Locale('en', 'US'),

              localizationsDelegates: const [
                // AppLocalization.delegate,
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ko', 'KO'),
                Locale('zh', 'VI'),
              ],
              localeResolutionCallback:
                  (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
                for (var locale in supportedLocales) {
                  if (locale.languageCode == deviceLocale!.languageCode &&
                      locale.countryCode == deviceLocale.countryCode) {
                    return deviceLocale;
                  }
                }
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              // initialRoute: SplashView.route,
              getPages: [
                GetPage(name: SplashScreen.route, page: () => const SplashScreen()),
                GetPage(name: OnBoardingView.route, page: () => const OnBoardingView()),
                GetPage(name: PersonelinfoView.route, page: () => const PersonelinfoView()),
                GetPage(name: PhoneView.route, page: () => const PhoneView()),
                GetPage(name: ReadRules.route, page: () => const ReadRules()),
                GetPage(name: RulesView.route, page: () => const RulesView()),
                GetPage(name: VerificationApprovedView.route, page: () => const VerificationApprovedView()),
                GetPage(name: SignInView.route, page: () => const SignInView()),
                GetPage(name: HomeView.route, page: () => const HomeView()),


                // GetPage(name: AuthView.route, page: () => const AuthView()),
                // GetPage(name: BaseView.route, page: () => const BaseView()),
                // GetPage(name: TodoView.route, page: () => const TodoView()),
                // GetPage(name: ProfileView.route, page: () => const ProfileView()),
              ],
              // title: 'Todo App',
              theme: ThemeData(
                primaryColor: AppColors.whiteColor,
              ),
              home:SplashScreen(),

              // Scaffold(
              //   body:
              //   PhotoGrid(
              //     maxImages: 4,
              //     imageUrls: [
              //       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              //       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              //       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              //       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              //       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              //       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              //       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              //     ],
              //     onImageClicked: (int ) {  },
              //     onExpandClicked: (){},
              //   ),
              // ),
            );
          }
      );
  }
}
