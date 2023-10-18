import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/components/default_button.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_strings.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import 'package:rapid_reaction/app/routes/app_routes.dart';
import 'package:rapid_reaction/domain/entities/reaction_result.dart';
import '../../../app/components/info_item.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reactionResult = ModalRoute.of(context)!.settings.arguments as ReactionResult;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppValues.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppStrings.gameOver, style: context.textTheme.titleLarge),
              const Spacer(flex: 1),
              InfoItem(icon: Icons.timer_rounded, title: AppStrings.reactionSpeed,
                  info: AppStrings.getTimeString(reactionResult.reactionSpeed)),
              InfoItem(icon: Icons.star_rounded, title: AppStrings.bestReaction,
                  info: AppStrings.getTimeString(reactionResult.bestReaction)),
              InfoItem(icon: Icons.trending_down_rounded, title: AppStrings.worstReaction,
                  info: AppStrings.getTimeString(reactionResult.worstReaction)),
              const Spacer(flex: 2),
              DefaultButton(text: AppStrings.done, onPressed: (){
                Navigator.pushNamed(context, AppRoutes.mainMenuRoute);})
            ],
          ),
        ),
      ),
    );
  }
}
