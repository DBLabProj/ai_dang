import 'dart:typed_data';

import 'package:image/image.dart' as libImg;
import 'package:http/http.dart';
import 'package:flutter/material.dart';



Future<Image> cropNetworkImage(String url, int resizeHeight, Map area) async {
  final rawBytes = (await get(Uri.parse(url))).bodyBytes;
  final img = libImg.decodeJpg(rawBytes);
  libImg.Image resizedImg = libImg.copyResize(img!, width: -1, height: resizeHeight);
  libImg.Image cropImg = libImg.copyCrop(resizedImg, area['x'].toInt(), area['y'].toInt(), area['w'].toInt(), area['h'].toInt());
  return Image.memory(Uint8List.fromList(libImg.encodeJpg(cropImg, quality: 100)), fit: BoxFit.cover,);
}