import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/FundRequestsController.dart';

class FundRequests extends GetWidget<FundRequestsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fund Requests'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => controller.myRequestList.value.isEmpty
                  ? Center(child: Text("No Request Data"))
                  : Expanded(
                      child: ListView.separated(
                        itemCount: controller.myRequestList.value.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          var data = controller.myRequestList.value[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("UserName: ${data.user?.name ?? ""}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      Text("Amount: ${data.amount ?? ""}"),
                                      const SizedBox(height: 8),
                                      Text("Notes: ${data.note.toString()}"),
                                      // const SizedBox(height: 4),
                                      // Text("Total Amount: Rs ${controller.totalAmount.toString()}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.reject(
                                            reqId: data.id.toString(),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          controller.accept(

                                            reqId: data.id.toString(),
                                            amount: data.amount.toString(),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ));
  }
}
