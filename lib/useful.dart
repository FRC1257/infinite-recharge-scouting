import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
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

Future<String> localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> localFile(String directory, String filename) async {
  final path = await localPath();
  File file =  File('$path/$directory/' + filename);
  bool exists = await file.exists();
  if (!exists) {
    file.create(recursive: true);
  }
  return file;
}

Future<File> writeText(String directory, String filename, String text, bool append) async {
  final file = await localFile(directory, filename);
  if (append) {
    String current = await readText(directory, filename);
    return file.writeAsString(current + text);
  } else {
    return file.writeAsString(text);
  }
}

Future<String> readText(String directory, String filename) async {
  try {
    final file = await localFile(directory, filename);
    String text = await file.readAsString();
    return text;
  } catch (e) {
    return "";
  }
}

Future<int> makeRequest(String formID, String text) async {
  try {
    String url = Uri.encodeFull('https://docs.google.com/forms/d/e/$formID/formResponse?entry.615575561=$text&submit=Submit');
    http.Response res = await http.get(url);
    return res.statusCode;
  } on SocketException {
    return 0;
  }
}