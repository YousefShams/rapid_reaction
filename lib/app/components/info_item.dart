import 'package:flutter/material.dart';

import '../../../../app/resources/app_colors.dart';
import '../../../../app/resources/app_fonts.dart';


class InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  final Color? iconColor;
  const InfoItem({Key? key, required this.icon,
    required this.title, required this.info,
    this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color:  iconColor ?? AppColors.primaryColorDarker),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: AppFonts.mediumFontWeight)),
      trailing: Text(info, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
