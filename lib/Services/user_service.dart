import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Models/AnalyticsModel.dart';
import 'package:hisab_kitab/Models/MembersModel.dart';
import 'package:hisab_kitab/Models/MessageModel.dart';
import '../Models/BaseModel.dart';
import '../Models/BudgetModel.dart';
import '../Models/FamilyMemberModel.dart';
import '../Models/InvitaitonModel.dart';
import '../Models/RequestFundListModel.dart';
import '../Models/User.dart';
import '../Utils/Constants.dart';
import '../Utils/Prefs.dart';
import '../Utils/restApi.dart';
import '../controllers/UserController.dart';

final userController = Get.find<UserController>();

Future<void> login(
    {required String email,
    required String password,
    required Function(User user) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.login,
      body: {
        'email': email,
        'password': password,
      },
      onSuccess: (basemodel) {
        userController.user.value = User.fromJson(basemodel.data["user"]);
        userController.user.value?.apiToken = basemodel.data["token"];
        Prefs.setUser(userController.user.value!);
        onSuccess(userController.user.value!);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> signUp(
    {required String name,
    String? image,
    required String email,
    required String username,
    required String password,
    required String password_confirmation,
    required String role,
    required Function(User user) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.signUP,
      body: {
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'password_confirmation': password_confirmation,
        "role": role.toLowerCase(),
      },
      files: {if (image != null) "image": image},
      onSuccess: (basemodel) {
        userController.user.value = User.fromJson(basemodel.data["user"]);
        userController.user.value?.apiToken = basemodel.data["token"];
        Prefs.setUser(userController.user.value!);
        onSuccess(userController.user.value!);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> inviteUser(
    {String? role,
    String? email,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.inviteUser,
      body: {"email": email, "role": role},
      onSuccess: (BaseModel basemodel) {
        // MemberModel user = MemberModel.fromJson(basemodel.data);

        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> createFamily(
    {String? name,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.createFamily,
      body: {"name": name},
      onSuccess: (BaseModel basemodel) {
        // MemberModel user = MemberModel.fromJson(basemodel.data);

        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getMyFamily(
    {required Function(List<FamilyMemberModel> data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.getMyFamily,
      onSuccess: (BaseModel basemodel) {
        print((basemodel.data));
        final userController = Get.find<UserController>();
        if (userController.user?.value?.role == "father") {
          List<FamilyMemberModel> users = (basemodel.data["members"] as List)
              .map((e) => FamilyMemberModel.fromJson(e))
              .toList();
          onSuccess(users);
        } else {
          List<FamilyMemberModel> users = (basemodel.data["members"] as List)
              .map((e) => FamilyMemberModel.fromJson(e))
              .toList();
          onSuccess(users);
        }
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getMyAssignedBudget(
    {required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.myBudgetAssigned,
      onSuccess: (BaseModel basemodel) {
        print((basemodel.data));
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> hasFamily(
    {required Function(bool data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.hasFamily,
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel.data);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getAllUsersList(
    {required Function(List<MemberModel> users) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.getAllUsers,
      onSuccess: (BaseModel basemodel) {
        print((basemodel.data as List));
        List<MemberModel> users = (basemodel.data as List)
            .map((e) => MemberModel.fromJson(e))
            .toList();
        onSuccess(users);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getMyInvitations(
    {required Function(List<InvitaitonModel> users) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.myInvitations,
      onSuccess: (BaseModel basemodel) {
        List<InvitaitonModel> users = (basemodel.data as List)
            .map((e) => InvitaitonModel.fromJson(e))
            .toList();
        onSuccess(users);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> acceptInvitation(
    {required String email,
    String? role,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.acceptInvitation,
      body: {"email": email, "role": role},
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

void forgetPassword(
    {required String email,
    required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.forgotPass,
      body: {
        'email': email,
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

void askAI(
    {required String question,
    required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.aiAsk,
      body: {'question': question, "table_name": "expenses"},
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

void aiHistory(
    {required Function(List<MessageModel> data) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.aiHistory,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List)
            .map((e) => MessageModel.fromJson(e))
            .toList());
      },
      onError: (String error) {
        onError(error);
      });
}

void analytics(
    {required Function(AnalyticsModel data) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.analytics,
      onSuccess: (BaseModel basemodel) {
        onSuccess(AnalyticsModel.fromJson(basemodel.data));
      },
      onError: (String error) {
        onError(error);
      });
}

void fundRequestAsk(
    {required String category_id,
    required String amount,
    required String note,
    required Function(AnalyticsModel data) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint: Constants.fundRequestAsk,
      body: {"category_id": category_id, "amount": amount, "note": note},
      onSuccess: (BaseModel basemodel) {
        onSuccess(AnalyticsModel.fromJson(basemodel.data));
      },
      onError: (String error) {
        onError(error);
      });
}

void fundRequestMy(
    {
    required Function(List<RequestFundListModel> data) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.fundRequestMy,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List).map((e) => RequestFundListModel.fromJson(e)).toList());
      },
      onError: (String error) {
        onError(error);
      });
}

void fundRequestFundsAll(
    {
    required Function(List<RequestFundListModel> data) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.fundRequestFundsAll,
      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List).map((e) => RequestFundListModel.fromJson(e)).toList());
      },
      onError: (String error) {
        onError(error);
      });
}

void fundRequestApprove(
    {
      required String reqId,
      required String amount,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint:"${Constants.fundRequestApprove}/$reqId",
      body: {
        "amount": amount
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

void fundRequestDecline(
    {
      required reqId,
    required Function(BaseModel data) onSuccess,
    required Function(String error) onError}) {
  invokeAsync(
      method: Method.Post,
      endPoint: "${Constants.fundRequestDecline}/$reqId",
      onSuccess: (BaseModel basemodel) {
        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}
