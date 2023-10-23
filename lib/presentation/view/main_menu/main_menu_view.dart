import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/components/default_button.dart';
import 'package:rapid_reaction/app/components/rapid_reaction_widget.dart';
import 'package:rapid_reaction/app/resources/app_strings.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import 'package:rapid_reaction/app/routes/app_routes.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppValues.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const RapidReactionWidget(),
                const Spacer(flex: 1),
                DefaultButton(onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.gameRoute);
                }, text: AppStrings.play),
                DefaultButton(onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.gameModesRoute);
                }, text: AppStrings.gameModes),
                DefaultButton(onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.howToPlayRoute);
                }, text: AppStrings.howToPlay),
                DefaultButton(text: AppStrings.scoreboard,
                  onPressed: (){ Navigator.pushNamed(context,AppRoutes.scoreboardRoute); }, ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
