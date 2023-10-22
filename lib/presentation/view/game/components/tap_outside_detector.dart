import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';

class TapOutsideDetector extends StatelessWidget {
  final Function onTap;
  const TapOutsideDetector({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.width, height: context.height,
        child: GestureDetector( onTap: () { onTap(); } )
    );
  }
}
