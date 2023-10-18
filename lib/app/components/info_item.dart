import 'package:flutter/material.dart';

import '../../../../app/resources/app_colors.dart';
import '../../../../app/resources/app_fonts.dart';


class InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  const InfoItem({Key? key, required this.icon,
    required this.title, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: AppColors.primaryColorDarker),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: AppFonts.mediumFontWeight)),
      trailing: Text(info, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
