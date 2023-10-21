import 'package:flutter/material.dart';

import '../../../../app/components/app_title.dart';
import '../../../../app/components/default_button.dart';
import '../../../../app/resources/app_strings.dart';
import '../../../../app/resources/app_values.dart';
import '../../../../app/routes/app_routes.dart';

class GameOverEmptyResultView extends StatelessWidget {
  const GameOverEmptyResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppValues.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppTitle(title: AppStrings.tryAgain),
              const Spacer(),
              DefaultButton(text: AppStrings.done, onPressed: (){
                Navigator.pushNamed(context, AppRoutes.mainMenuRoute);})
            ],
          ),
        ),
      ),
    );
  }
}
