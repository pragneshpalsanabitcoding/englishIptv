import 'dart:convert';



import 'package:http/http.dart' as http;

import '../main.dart';
import 'FirebaseDatabaseUtil.dart';
import 'SettingsModel.dart';

String settingsUrl='';


Future<Settings> fetchAlbum() async {

  await FirebaseDatabaseUtil.instance.initState();

  dynamic settingsData =
  await FirebaseDatabaseUtil.instance.readData("Settings_Data");

  if (settingsData != null) {

    settingsUrl = settingsData["english_url"];
    print("SettingUrl======${settingsUrl}");
  } else {
    settingsUrl =
    "https://raw.githubusercontent.com/pkbitcoding/iptv_channels/main/All_Country_App/English/App_Setting.json";
  }


  final response = await http
      .get(Uri.parse(settingsUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON
    return modelApi = Settings.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}



