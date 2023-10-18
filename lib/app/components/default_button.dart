import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_assets.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';

class DefaultButton extends StatefulWidget {
  final Function onPressed;
  final String text;

  const DefaultButton({Key? key, required this.onPressed,
    required this.text}) : super(key: key);

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {

  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setSourceAsset(AppAssets.buttonClickSound);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppValues.buttonWidth,
      child: Padding(
        padding: const EdgeInsets.all(AppValues.buttonPadding),
        child: FilledButton(
            onPressed: () async {
              await player.play(AssetSource(AppAssets.buttonClickSound));
              widget.onPressed();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppValues.buttonPadding),
              child: Text(widget.text, style:context.textTheme.bodyMedium),
            )
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
