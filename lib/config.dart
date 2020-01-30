import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

Color backgroundColor = Colors.red;
double fontSize = 16.0;
const API_KEY = '2095f79d474943dabcc9e6c3efed7fb5';
const AGORA_ID = '5a9a3760d44d43eca64e68e8406ab438';
const FAILURE = 'Connection Failed';
const appName = 'Vinter';
const country = 'Nigeria';
int currentScreen = 0;

Country defaultCountry = Country(
  asset: "assets/flags/ng_flag.png",
  dialingCode: "234",
  isoCode: "NG",
  currency: 'NGN',
  currencyISO: 'NG',
  name: "Nigeria",
);

final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
Position _currentPosition;

class Converter {
  String serialize(Country t) {
    var map = {
      "name": t.name,
      "dialingCode": t.dialingCode,
      "asset": t.asset,
      "isoCode": t.isoCode
    };
    return json.encode(map);
  }

  String convertToDate(dynamic timestamp) {
    var now =  DateTime.now();
    var format =  DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }
    return time;
  }
}

Future<String> getCurrentLocation() async {
  String location;
  await geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) async {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place = p[0];

    location = place.country != null && place.subLocality != null
        ? '${place.locality}, ${place.country}'
        : 'Abuja, Nigeria';
  }).catchError((e) {
    print(e);
  });
  return location;
}

saveCountry(Country country) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('country', Converter().serialize(country));
}

getCountry() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String country = prefs.getString('country');
  if (country != '' && country != null) {
    return country;
  }
  return Converter().serialize(defaultCountry);
}

class Application {
  BuildContext context;
  Application(BuildContext context) {
    this.context = context;
  }

  clearFocus() {
    FocusScopeNode currentScope = FocusScope.of(context);
    FocusScopeNode rootScope = WidgetsBinding.instance.focusManager.rootScope;

    if (currentScope != rootScope) {
      currentScope.unfocus();
    }
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null ||
      int.parse(s, onError: (e) => null) != null;
}
