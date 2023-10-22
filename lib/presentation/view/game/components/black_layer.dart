import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';

class BlackLayer extends StatelessWidget {
  const BlackLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width, height: context.height,
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
    );
  }
}
