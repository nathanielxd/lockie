import 'dart:convert';
import 'package:flutter/services.dart';

class DynamicAssets {

  static List<String> fileNames = [];

  static Future<void> load() async {

    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final paths = manifestMap.keys
      .where((String key) => key.startsWith('assets/logo/'))
      .map((e) => e
        .split('/').last
        .split('.').first
      )
      .where((element) => element.isNotEmpty);

    fileNames = List.from(paths);
  }

  static String? containedFile(String value) {
    for(var element in fileNames) {
      if(value.toLowerCase().contains(element)) {
        return element;
      }
    }
    return null;
  }
}