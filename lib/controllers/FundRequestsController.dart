import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/RequestFundListModel.dart';
import '../Services/user_service.dart';
import '../Utils/utils.dart';

class FundRequestsController extends GetxController {
  RxList<RequestFundListModel> myRequestList = RxList<RequestFundListModel>();
  getMyRequest() {
    showLoading();
    fundRequestFundsAll(
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

  accept({required String reqId,required String amount,}){
    showLoading();
    fundRequestApprove(
      amount:amount ,
      reqId: reqId,
      onSuccess: (data) {
      hideLoading();
      Get.snackbar("Success", "Request Accepted", backgroundColor: Colors.green,colorText: Colors.white);
      getMyRequest();
    }, onError: (error) {
      hideLoading();
      Get.snackbar("Error", error, backgroundColor: Colors.red,colorText: Colors.white);
    },);
  }
 reject({required String reqId}) {
    showLoading();
    fundRequestDecline(
      reqId:reqId ,
      onSuccess: (data) {
      hideLoading();
      Get.snackbar("Success", "Request Rejected", backgroundColor: Colors.green,colorText: Colors.white);
      getMyRequest();
    }, onError: (error) {
      hideLoading();
      Get.snackbar("Error", error, backgroundColor: Colors.red,colorText: Colors.white);
    },);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getMyRequest();
    super.onInit();
  }
}