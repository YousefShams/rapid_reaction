import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import '../../../../app/resources/app_colors.dart';
import '../../../../app/resources/app_fonts.dart';


class ScoreItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String info;

  const ScoreItem({Key? key, required this.index, required this.info,
    required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: AppColors.primaryColorDarker),
      title: Text(getIndexString(index), style: context.textTheme.bodyMedium
          ?.copyWith(fontWeight: AppFonts.mediumFontWeight)),
      trailing: Text(info, style: context.textTheme.titleMedium),
    );
  }


  String getIndexString(int index) {
    return (index==1) ? "${index}st" : ((index==2) ? "${index}nd" :
      ((index==3) ? "${index}rd" : "${index}th" ));
  }
}
