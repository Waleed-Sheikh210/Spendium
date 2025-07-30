import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Services/user_service.dart';
import 'package:hisab_kitab/Utils/utils.dart';

import '../Models/RequestFundListModel.dart';

class MyFundRequestScreenController extends GetxController {
  RxList<RequestFundListModel> myRequestList = RxList<RequestFundListModel>();
  getMyRequest() {
    showLoading();
    fundRequestMy(
      onSuccess: (data) {
        hideLoading();
        myRequestList.value = data;
        update();
      },
      onError: (error) {
        hideLoading();
        Get.snackbar("Error", error, backgroundColor: Colors.red,colorText: Colors.white);
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getMyRequest();
    super.onInit();
  }
}
