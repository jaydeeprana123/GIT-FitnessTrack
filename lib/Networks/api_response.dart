import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../CommonWidgets/common_widget.dart';


class Request {
  final String? url;
  final dynamic body;

  Request({this.url, this.body});


  Future<http.StreamedResponse> postAPIwithoutBearer(url, body) async {
    Map<String, String> headersWithBearer = {
      'Content-Type': 'application/json',
    };

    printData("url", url);
    printData("Body", body.toString());
    printData("Header", headersWithBearer.toString());

    if (body != null) {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields.addAll(body);
      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      return response;
    } else {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      return response;
    }
  }

  Future<http.StreamedResponse> postWithOutTokenAPI(url, body) async {
    printData("url", url);
    printData("Body", body.toString());

    if (body != null) {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields.addAll(body);

      http.StreamedResponse response = await request.send();

      return response;
    } else {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      http.StreamedResponse response = await request.send();

      return response;
    }
  }

  Future<http.StreamedResponse> postMedicartAPI(url, body, token) async {
    Map<String, String> headersWithBearer = Map();

    if (body != null) {
      if (token != null) {
        headersWithBearer = {
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Bearer ' + token,
        };
      }

      log("url :: " + url.toString());
      log("Header :: " + headersWithBearer.toString());
      log("body :: " + body.toString());

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(body);
      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      return response;
    } else {
      if (token != null) {
        headersWithBearer = {
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Bearer ' + token,
        };
      }
      var request = http.MultipartRequest('GET', Uri.parse(url));

      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      return response;
    }
  }

  Future<http.StreamedResponse> postMethodMedicartAPI(url, body, token) async {
    Map<String, String> headersWithBearer = Map();

    if (token != null) {
      headersWithBearer = {
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Bearer ' + token,
      };
    }

    printData("url", url);
    // printData("Body", body.toString());
    printData("Header", headersWithBearer.toString());

    if (body != null) {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // request.fields.addAll(body);
      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      return response;
    } else {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      return response;
    }
  }

  Future<http.StreamedResponse> postAPI(url, body, token) async {
    Map<String, String> headersWithBearer;

    headersWithBearer = {
      'Content-Type': 'application/json',
      // ignore: prefer_interpolation_to_compose_strings
      'Authorization': 'Bearer ' + token,
    };

    printData("url", url);
    printData("Body", body.toString());
    printData("Header", headersWithBearer.toString());

    if (body != null) {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields.addAll(body);
      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      // await response.stream.bytesToString().then((response) async {
      //   printData("Mayank test", "0");
      //   Map<String, dynamic> userModel = json.decode(response.toString());
      //   BaseModel model = BaseModel.fromJson(userModel);
      //
      //   if (model.statusCode == 403) {
      //     logoutFromTheApp();
      //   }
      //   printData("Mayank result", "0");
      //
      // });

      return response;
    }
    else {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      // await response.stream.bytesToString().then((response) async {
      //   printData("Mayank test", response);
      //
      //   String abc = response;
      //   Map<String, dynamic> userModel = json.decode(abc);
      //   BaseModel model = BaseModel.fromJson(userModel);
      //
      //   if (model.statusCode == 403) {
      //     logoutFromTheApp();
      //   }
      //   printData("Mayank result", "1");
      //
      // });

      return response;
    }
  }

  Future<http.StreamedResponse> getMethodAPI(url, body, token) async {
    Map<String, String> headersWithBearer;

    headersWithBearer = {
      'Content-Type': 'application/json',
      // ignore: prefer_interpolation_to_compose_strings
      'Authorization': 'Bearer ' + token,
    };

    printData("url", url);
    printData("Body", body.toString());
    printData("Header", headersWithBearer.toString());

    if (body != null) {
      var request = http.MultipartRequest('GET', Uri.parse(url));

      request.fields.addAll(body);
      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      return response;
    } else {
      var request = http.MultipartRequest('GET', Uri.parse(url));

      request.headers.addAll(headersWithBearer);
      http.StreamedResponse response = await request.send();

      return response;
    }
  }

  // // logout from the app
  // logoutFromTheApp() async {
  //   printData("Session out", '403');
  //   var preferences = MySharedPrefNew();
  //   await preferences.clearKey(SharePreData.keySaveLoginModel);
  //   await preferences.clearKey(SharePreData.keyToken);
  //   Get.offAll(const LoginViaMobileNumView());
  //
  // }

  Future<http.StreamedResponse> postAPIWithMedia(
      url, body, token, String strImg) async {
    Map<String, String> headersWithBearer = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token,
    };
    printData("url", url);
    printData("Body", body.toString());
    printData("Header", headersWithBearer.toString());
    printData("strImg", strImg);

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields.addAll(body);

    if (strImg.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('image', strImg));
    }

    request.headers.addAll(headersWithBearer);
    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.StreamedResponse> postAPIWithMediaWithoutBearer(
      url, body, strImg) async {
    Map<String, String> headersWithBearer = {
      'Content-Type': 'multipart/form-data',
    };

    printData("url", url);
    printData("Body", body.toString());
    printData("Header", headersWithBearer.toString());
    printData("strImg", strImg);

    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (strImg != null && strImg.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('image', strImg));
    }

    request.fields.addAll(body);

    request.headers.addAll(headersWithBearer);
    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.StreamedResponse> postAPIWithMediaWithoutToken(
      url, body, strImg) async {
    Map<String, String> headersWithBearer = {
      'Content-Type': 'application/json',
      // 'Authorization': token,
    };
    printData("url", url);
    printData("Body", body.toString());
    printData("Header", headersWithBearer.toString());
    printData("strImg", strImg);

    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (strImg != null && strImg != "") {
      request.files.add(await http.MultipartFile.fromPath('image', strImg));
    }

    request.fields.addAll(body);

    request.headers.addAll(headersWithBearer);
    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.Response> postWithoutBearer(url, token) {
    Map<String, String> headersWithBearer = {
      'Content-Type': 'application/json',
      // ignore: prefer_interpolation_to_compose_strings
      'Authorization': 'Bearer ' + token,
    };

    print(url);
    print(body);
    print(headersWithBearer);
    return http
        .post(Uri.parse(url), headers: headersWithBearer, body: body)
        .timeout(const Duration(minutes: 5));
  }

  Future<http.Response> postWithBearer(url, body, token) {
    Map<String, String> headersWithBearer = {
      'Authorization': 'Bearer ' + token,
    };

    print(url);
    print(body);
    print(headersWithBearer);
    return http
        .post(Uri.parse(url), headers: headersWithBearer, body: body)
        .timeout(const Duration(minutes: 5));
  }

  Future<http.Response> postWithoutToken(url) {
    Map<String, String> headersWithBearer = {
      'Content-Type': 'application/json',
    };

    print(url);
    print(body);
    print(headersWithBearer);
    return http
        .post(Uri.parse(url), headers: headersWithBearer)
        .timeout(const Duration(minutes: 5));
  }
}
