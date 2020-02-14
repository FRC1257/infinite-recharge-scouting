import 'dart:async';

import 'package:http/http.dart' as http;

class Boolean {
  bool b;
  Boolean(bool b) {
    this.b = b;
  }
  void makeFalse() {
    b = false;
  }
  void makeTrue() {
    b = true;
  }
  bool getBool() {
    return b;
  }
}

Future<int> makeRequest(String formID, String text) async {
  try {
    String url = Uri.encodeFull('https://docs.google.com/forms/d/e/$formID=$text&submit=Submit');
    http.Response res = await http.get(url);
    return res.statusCode;
  } on Exception {
    return 0;
  }
}