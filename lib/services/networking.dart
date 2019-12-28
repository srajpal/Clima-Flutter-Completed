import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// class to fetch data using HTTP
class NetworkHelper {
  NetworkHelper({@required this.url});
  final String url;

  Future<dynamic> fetchData() async {
    print('NetworkHelper::fetchData()');
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      print(response.body);
      return jsonDecode(response.body);
    }
  }
}
