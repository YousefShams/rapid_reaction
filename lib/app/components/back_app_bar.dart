import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';

AppBar getBackAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      onPressed: () { Navigator.pop(context); },
      icon: Icon(Icons.arrow_back_ios_new_rounded,
      color: context.textTheme.bodyMedium?.color,)
    )
  );
}