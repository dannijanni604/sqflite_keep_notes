import 'package:flutter/material.dart';

successSnackBar (context){
  return  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task Added')));
}

errorSnackBar ({required BuildContext context, required String error}){
  return  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
}