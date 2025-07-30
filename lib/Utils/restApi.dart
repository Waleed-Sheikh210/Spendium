import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Utils/paths.dart';
import 'package:hisab_kitab/Utils/utils.dart';
import 'package:hisab_kitab/views/Auth/SignUpScreen.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import '../Models/BaseModel.dart';

import '../Models/User.dart';
import '../main.dart';
import 'Prefs.dart';
import 'constants.dart';
import 'encrypt.dart';

String baseUrl = Constants.baseUrl;

Future<dynamic> POST_JSON(String endPoint, jsonBody,
    {String? authToken,String? path}) async {
  // set up POST request arguments
//  String url = 'https://jsonplaceholder.typicode.com/posts';
  Map<String, String> headers = {
    // if(authToken != null)  "Content-Type": "application/json",
    if(authToken != null)  "Accept": "application/json",
    if(authToken != null) "Authorization": "Bearer ${authToken}" ??
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjUsImlhdCI6MTU3MDc3NDE0NX0.KpeFmLLKXmqmDFhP4Jr_6i-fbhQFLwiIPuSlB6Izfvw",
  };
//  String json = '{"title": "Hello", "body": "body text", "userId": 1}';
  // make POST request
  String url = baseUrl + endPoint + '${path ?? ""}';
  http.Response response = await http.post(Uri.parse(url),
      headers: headers, body: jsonBody != null ? (jsonBody) : null);

  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  if (statusCode == 200 || statusCode == 400 || statusCode == 201) {
    String body = response.body;
    body = utf8.decode(body.runes.toList());
    var jsonBody = json.decode(body);
    print(body);
    return BaseModel.fromJson(jsonBody);
    // return jsonBody;
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<BaseModel> DELETE(String endPoint,
    {String? authToken, required String id}) async {
  Map<String, String> headers = {
    "Authorization": authToken ??
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjUsImlhdCI6MTU3MDc3NDE0NX0.KpeFmLLKXmqmDFhP4Jr_6i-fbhQFLwiIPuSlB6Izfvw",
  };
  String bUrl = baseUrl + endPoint;
  final url = Uri.encodeFull(bUrl + id);
  http.Response response = await http.delete(
    Uri.parse(url),
    headers: headers,
  );
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  if (statusCode == 200) {
    String body = response.body;
    var jsonBody = json.decode(body);
    print(body);
    return BaseModel.fromJson(jsonBody);
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<BaseModel> POST_FORM_DATA(String endPoint, Map<String, dynamic> body,
    {String? authToken}) async {
//  String url = 'https://360cubes.com/urantia_staging/public/api/user/login';

  Map<String, String> headers = {
//    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": authToken ??
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjUsImlhdCI6MTU3MDc3NDE0NX0.KpeFmLLKXmqmDFhP4Jr_6i-fbhQFLwiIPuSlB6Izfvw",
  };
//  Map<String, String> body = {
//    'email': 'android@reader.com',
//    'password': '123456',
//  };
  // make POST request
  http.Response response = await http.post(Uri.parse(baseUrl + endPoint),
      headers: headers, body: body);
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  if (statusCode == 200) {
    String body = response.body;
    var jsonBody = json.decode(body);
    print(body);
    return BaseModel.fromJson(jsonBody);
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<BaseModel> MultiPart(String endPoint, Map<String, dynamic> body,
    Map<String, dynamic>? files,
    {String? authToken, String? path}) async {
  var uri = Uri.parse(baseUrl + endPoint + "${path ?? ""}");
  var request = http.MultipartRequest('POST', uri);
  // if (authToken!=null) {
  request
    ..headers.addAll({
      if (authToken != null) "Authorization": "Bearer $authToken",
      "Accept": "application/json",
    });
  // }

  body.forEach((key, value) {
    if (value is List) {
      var val = (value.toList());
      for (var i = 0; i < val.length; i++) {

        request.fields["$key[$i]"] = val[i];
      }
    } else {
      request.fields[key] = value.toString();
    }
  });

  if (files != null && files.isNotEmpty) {
    files.forEach((key, value) async {
      if (value is List) {
        var val = (value as List);
        for (var i = 0; i < val.length; i++) {
          var file = val[i];
          request.files.add(await http.MultipartFile.fromPath(
            '$key[$i]',
            file,
            contentType: MediaType('image', 'jpeg'),
          ));
        }
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          key,
          value,
          contentType: MediaType('image', 'jpeg'),
        ));
      }
    });
  }

  var response = await request.send();
  int statusCode = response.statusCode;
  if (statusCode == 200 || statusCode == 400 || statusCode == 201) {
    String bodyString = await response.stream.bytesToString();
    // body = utf8.decode(body.runes.toList());
    var jsonBody = json.decode(bodyString);
    print(bodyString);
    return BaseModel.fromJson(jsonBody);
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<BaseModel> GET(String endPoint,
    {String? authToken, Map<String, dynamic>? params, String? path}) async {
//  String url = 'https://360cubes.com/urantia_staging/public/api/user/login';

  Map<String, String> headers = {
    // "Content-Type": "application/json",
    "Authorization": "Bearer  $authToken" ??
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjUsImlhdCI6MTU3MDc3NDE0NX0.KpeFmLLKXmqmDFhP4Jr_6i-fbhQFLwiIPuSlB6Izfvw",
  };
  String url = baseUrl + endPoint + "${path ?? ""}";
  Uri parsedUri = Uri.parse(url);
  var uri = parsedUri.replace(queryParameters: params);
  http.Response response = await http.get(
    params != null ? uri : parsedUri,
    headers: headers,
  );
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  if (statusCode == 200 || statusCode == 400 || statusCode == 201) {
    String body = response.body;
    body = utf8.decode(body.runes.toList());
    var jsonBody = json.decode(body);
    print(body);

    return BaseModel.fromJson(jsonBody);
  } else if(statusCode == 401) {
Prefs.removeUser();
// Navigator.pushAndRemoveUntil(navigationKey.currentContext!, MaterialPageRoute(builder: (context) => SignUpScreen(),), (route) => false);
throw Exception(response.reasonPhrase);
  }    else
{
    throw Exception(response.reasonPhrase);
  }
}

enum Method { Get, Post, Multipart, Delete }

Future<void> invokeAsync(
    {required String endPoint,
      required Method method,
      Map<String, dynamic>? body,
      Map<String, dynamic>? files,
      String? pathVariable,
      required Function( BaseModel data) onSuccess,
      required Function(String error) onError}) async {
  if (await isConnected()) {
    print("API EndPoint: $endPoint \nMethod: ${describeEnum(method)}");
    try {
      User? user = (await Prefs.getUserSync());
      String? authToken =
      user != null && user.apiToken != null && user.apiToken!.isNotEmpty
          ? user.apiToken!
          : null;
      dynamic baseModel;
//      = (method == Method.Get)`
//          ? await GET(endPoint,authToken: authToken)
//          : await POST_FORM_DATA(endPoint, body, authToken: authToken);
      if (body != null) print("Request Body: " + body.toString());
      if (files != null && files.isNotEmpty)
        for (var file in (files.values.toList())) {
          print("Request Body File: " + file.toString());
        }
      switch (method) {
        case Method.Get:
          baseModel = await GET(endPoint,
              authToken: authToken, path: pathVariable, params: body);
          break;

        case Method.Post:
          baseModel = await POST_JSON(
              endPoint,
              body,
              authToken: authToken,
              path: pathVariable
          );
          break;

        case Method.Delete:
          baseModel =
          await DELETE(endPoint, authToken: authToken, id: pathVariable!);
          break;

        case Method.Multipart:
        default:
          baseModel = await MultiPart(
            endPoint,
            body!,
            files,
            path: pathVariable,
            authToken: authToken,
          );
      }

      if (baseModel.code == 200 || baseModel.code == 201)
        onSuccess(baseModel);
      else if (baseModel.code == 400) {
        var dataJson =baseModel.data != null ? baseModel.data as Map<String, dynamic> : {};
        onError(baseModel.data != null ? dataJson.values.first : baseModel.message!);
      }
      else {
        onError(baseModel.message!);
        if (baseModel.message == "User is blocked or deleted by admin") {
          // toast("Logging Out");
          Prefs.removeUser();
         Get.offAllNamed(Paths.signupScreenPath);
        }
      }
    } catch (error) {
      print(error.toString());
      onError(error.toString());
    }
  } else {
    onError(Constants.CHECK_INTERNET);
  }
}

Future<BaseModel> invoke(
    {required String endPoint,
      required Method method,
      Map<String, dynamic>? body,
      String? authToken}) async {
//  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  if (await isConnected()) {
    print(baseUrl + endPoint);
    BaseModel baseModel = (method == Method.Get)
        ? await GET(endPoint, authToken: authToken)
        : await POST_FORM_DATA(endPoint, body!, authToken: authToken);
    if (baseModel.code == 200)
      return baseModel;
    else
      throw baseModel.message!;
  } else {
    throw Constants.CHECK_INTERNET;
  }
}