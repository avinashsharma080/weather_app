import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getdata() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      return Text("fuck");
    }
  }
}
