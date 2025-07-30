
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Utils/ColorUtils.dart';
import '../Utils/ImageUtils.dart';
import '../Utils/fontUtils.dart';
import '../controllers/SplashScreenController.dart';

class SplashScreen extends GetWidget<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.teal,
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: GetBuilder<SplashScreenController>(builder: (controller) {
                return AnimatedOpacity(
                    opacity: controller.isInitialized1.value == true ? 1 : 0,

                    duration: Duration(seconds: 1),

                    curve: Curves.easeIn,
                    child:Text("S",style: TextStyle(
                      color: ColorUtils.black,
                      fontSize: 100.sp,
                      fontFamily: FontUtils.Bold
                    ),));
              }),
            ),
            GetBuilder<SplashScreenController>(builder: (controller) {
              return AnimatedOpacity(
                  opacity: controller.isInitialized1.value == true ? 1 : 0,

                  duration: Duration(seconds: 1),

                  curve: Curves.easeIn,
                  child:Text("Spendium ",style: TextStyle(
                    color: ColorUtils.black,
                    fontSize: 30.sp,
                    fontFamily: FontUtils.Bold
                  ),));
            }),
          ],
        ),
      ),
    );
  }
}
