import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';

class ExpandableHowToPlay extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Color iconColor;
  final String info;
  const ExpandableHowToPlay({Key? key, required this.title,
    required this.iconData, required this.iconColor, required this.info}) : super(key: key);

  @override
  State<ExpandableHowToPlay> createState() => _ExpandableHowToPlayState();
}

class _ExpandableHowToPlayState extends State<ExpandableHowToPlay> {
  bool opened = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppValues.smallPadding),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: widget.iconColor.withOpacity(0.25),
        leading: Icon(widget.iconData, color: widget.iconColor),
        title: Text(widget.title, style: TextStyle(
            color: opened ? widget.iconColor : context.textTheme.bodyMedium?.color)),
        childrenPadding: const EdgeInsets.all(AppValues.pagePadding),
        onExpansionChanged: (_) { setState(() { opened=!opened; }); },
        trailing: Icon(opened ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
            color: context.textTheme.bodyMedium?.color, size: 33,),
        children: [ Text(widget.info) ],
      ),
    );
  }
}
