import 'package:flutter/material.dart';
import 'package:sqflite_keep_notes/config/constants.dart';

ThemeData lightTheme (){
  return ThemeData(
    scaffoldBackgroundColor: kPrimaryColor,
    appBarTheme:  const AppBarTheme(backgroundColor: kPrimaryColor,centerTitle: true,elevation: 2)
  );
}



ThemeData darkTheme (){
  return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: kPrimaryDarkColor,centerTitle: true,elevation: 2)
  );
}