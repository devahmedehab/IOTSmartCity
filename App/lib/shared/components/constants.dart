import 'package:flutter/material.dart';
import 'package:smart_city/modules/login/parking_login_screen.dart';
import 'package:smart_city/modules/register/register_screen.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/network/cache_helper.dart';

import 'dart:ui';

const Color kBgColor = Color(0xFFecf5fb);
const Color kOrangeColor = Color(0xFFF07662);
const Color kDarkGreyColor = Color.fromARGB(255, 59, 78, 90);
const Color kGreenColor = Color(0xA8C7DCE5);
const Color kBlueColor = Color(0x3B4E5A);
const defaultColor = Colors.blue;
bool isDark=false;
void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        ParkingLoginScreen(),
      );
    }
  });
}



void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
var uid = '';
String username='';
String email='';
String phone='';
String carStr='';
String carInt='';
String oldPassword='';
String newPassword='';
List leds;
Color color=Colors.white;

 final String oneSignalId= "c6218e1e-82ad-420b-bcad-3d626af97d6d";

var slots1;
var slots2;
var slots3;
var slots4;
var slots5;
var slots6;
var freeSlots;
var temp;
var gas;
var hum;
var rain;
var led_1;
var led_2;
var led_3;
var led_4;
var led_5;
var led_6;



