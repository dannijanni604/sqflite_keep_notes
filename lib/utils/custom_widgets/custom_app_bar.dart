import 'package:flutter/material.dart';

AppBar customAppBar({required String title,  IconData? icon,  VoidCallback? onActionTap}) {
  return AppBar(
    title: Text(title),
    actions:icon != null? [IconButton(onPressed: onActionTap, icon: Icon(icon))]:null,
  );
}
