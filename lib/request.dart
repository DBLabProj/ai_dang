// 비동기 처리를
import 'package:ai_dang/views/predResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

Future predict(context, imageSource, picker) async {
  XFile? image = await picker.pickImage(source: imageSource);

  if(image != null) {
    EasyLoading.show(status: '전송 중...');
    var sendData = await transImage(image);
    var predData = await sendImage(sendData);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PredResultPage(
              predResult: predData, image: File(image.path))),
    );
    EasyLoading.dismiss();
  }

}

Future insertMeal(user, amount, predictNo, desc)  async{
  http.Response response = await http.post(
    Uri.parse('http://203.252.240.74:5000/add_meal'),
    body: {
      'user': user, 'amount': amount, 'pred_no': predictNo, 'desc': desc
    }
  );

  return response;
}

Future boardImage(context, imageSource, picker) async {
  XFile? image = await picker.pickImage(source: imageSource);

  if(image!=null) {
    EasyLoading.show(status: "업로드 중...");
    var saveImage = await transImage(image);
    var checkImage = await uploadImage(saveImage);

    print(checkImage);
    EasyLoading.dismiss();
    return checkImage;

  }
}

Future transImage(XFile? image) async {
  if (image != null) {
    return await MultipartFile.fromFile(image.path);
  }
  return null;
}

Future uploadImage(var image) async {
  var requestUri = Uri.encodeFull('http://203.252.240.74:5000/uploadImage');
  var formData = FormData.fromMap({"file": image});

  var dio = Dio();
  // Dio 패키지 사용하여 REST API 서버와 통신
  try {
    dio.options.contentType = 'multipart/form-data';
    dio.options.maxRedirects.isFinite;
    var response = await dio.post(requestUri, data: formData);
    print(response.data);
    return response.data;
  } catch(e) {
    print(e);
  }
}

Future sendImage(var image) async {
  var requestUri = Uri.encodeFull('http://203.252.240.74:5000/predict');
  var formData = FormData.fromMap({"file": image});

  var dio = Dio();
  // Dio 패키지 사용하여 REST API 서버와 통신
  try {
    dio.options.contentType = 'multipart/form-data';
    dio.options.maxRedirects.isFinite;
    var response = await dio.post(requestUri, data: formData);
    return response.data;
  } catch(e) {
    print(e);
  }
}