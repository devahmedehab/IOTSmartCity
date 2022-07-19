import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components/constants.dart';

ThemeData darkTheme =ThemeData(
  primarySwatch: defaultColor,
  iconTheme: IconThemeData(
      color: Colors.white
  ),

  cardColor: Colors.grey,
  drawerTheme: DrawerThemeData(backgroundColor:HexColor('333739') ),


  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light
    ),

    backgroundColor: HexColor('333739'),
    elevation: 0,
    titleTextStyle: TextStyle(
        fontFamily: 'RobotoCondensed',
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),

    subtitle1: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.3,

    ),


  ),
  fontFamily: 'RobotoCondensed',
);

ThemeData lightTheme= ThemeData(
  drawerTheme: DrawerThemeData(
      backgroundColor: Colors.blue,
  ),
  cardColor: Colors.white,
  primarySwatch: defaultColor,

  scaffoldBackgroundColor: Colors.white,


  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.dark
    ),

    backgroundColor: Colors.blue,
    elevation: 0,
    titleTextStyle: TextStyle(
        fontFamily: 'RobotoCondensed',
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey[550],
    elevation: 20,
    backgroundColor: Colors.white,
  ),


  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
       color: Colors.black
    ),
    subtitle1: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3,
    ),

  ),
  fontFamily: 'RobotoCondensed',
);