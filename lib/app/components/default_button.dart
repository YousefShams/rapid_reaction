import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const DefaultButton({Key? key, required this.onPressed,
    required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(AppValues.buttonPadding),
        child: FilledButton(
            onPressed: (){ onPressed(); },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppValues.buttonPadding),
              child: Text(text, style:context.textTheme.bodyMedium),
            )
        ),
      ),
    );
  }
}
