
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/controllers/UserController.dart';
import 'package:oktoast/oktoast.dart';
import 'Utils/ColorUtils.dart';
import 'Utils/fontUtils.dart';
import 'Utils/paths.dart';
import 'Utils/routes.dart';
import 'Utils/screen_bindings.dart';
final navigationKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark,);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(UserController());
  runApp(const MyApp());

  ErrorWidget.builder = (details) {
    return Material(
      child: Container(
          color: Colors.indigoAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Center(
              child: Text(
                details.exceptionAsString(),
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
          )),
    );
  };
}

void configLoading() {
  EasyLoading.instance
  // ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle =EasyLoadingStyle.custom
    ..indicatorSize = 20.0
    ..radius = 10.0
    ..progressColor = ColorUtils.white
    ..backgroundColor = Colors.black
    ..indicatorColor = ColorUtils.white
    ..textColor = ColorUtils.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    configLoading();
    // TODO: implement initState
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(child: ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigationKey,
          builder: EasyLoading.init(),

          theme: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                  selectionHandleColor: ColorUtils.white,
                  selectionColor: ColorUtils.lightBlue),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
              }),
              fontFamily: FontUtils.SemiBold,
              hintColor: ColorUtils.lightSlate,
              scaffoldBackgroundColor: ColorUtils.cyan,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: ColorUtils.teal,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.white),
                  titleSpacing: 0,
                  titleTextStyle: TextStyle(
                      fontFamily: FontUtils.SemiBold,
                      fontSize: 18.sp,
                      // fontWeight: FontWeight.w600,
                      color: ColorUtils.white)),
              //            Commenting button theme because its also getting applied to flat buttons
              //              buttonTheme: ButtonThemeData(
              //                buttonColor: Colors.indigo[800],
              //                height: 40,
              //                shape: RoundedRectangleBorder(
              //                  borderRadius: BorderRadius.circular(30),
              //                  side: BorderSide(color: Theme.of(context).primaryColor),
              //                ),
              //              ),
              //          primaryColorDark: Colors.white,
              //          accentColor: Colors.white,

              brightness: Brightness.light),
          title: 'Hisab kitab',
          getPages: Routes.getPages(),
          themeMode: ThemeMode.light,
          initialRoute: Paths.splashScreenPath,
          initialBinding: ScreenBindings(),
        );
      },

    ));
  }
}
