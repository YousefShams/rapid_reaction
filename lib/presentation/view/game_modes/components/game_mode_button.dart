import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_enums.dart';
import '../../../../app/resources/app_colors.dart';
import '../../../../app/resources/app_fonts.dart';


class GameModeButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final GameMode gameMode;
  final bool isSelected;
  final Function onSelected;

  const GameModeButton({Key? key, required this.icon,
    required this.title, this.iconColor, required this.gameMode,
    required this.isSelected, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      selectedTileColor: AppColors.defaultIconColor?.withOpacity(0.5),
      onTap: () { onSelected(gameMode); },
      leading: Icon(icon,color:  iconColor ?? AppColors.defaultIconColor),
      title: Text(title, style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: AppFonts.mediumFontWeight)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.defaultIconColor)

    );
  }
}
