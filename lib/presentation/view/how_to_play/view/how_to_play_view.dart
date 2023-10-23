import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/components/app_title.dart';
import 'package:rapid_reaction/app/components/back_app_bar.dart';
import 'package:rapid_reaction/app/resources/app_colors.dart';
import 'package:rapid_reaction/app/resources/app_strings.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import 'package:rapid_reaction/presentation/view/how_to_play/view/components/expandable_how_to_play.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getBackAppBar(context),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppValues.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitle(title: AppStrings.howToPlay, big: true),
              SizedBox(height: AppValues.verticalSpaceBetweenSections),
              ExpandableHowToPlay(
                title: AppStrings.howToPlayNormalTitle,
                iconData: Icons.touch_app_rounded,
                iconColor: AppColors.primaryColor,
                info: AppStrings.howToPlayNormalInfo
              ),
              ExpandableHowToPlay(
                  title: AppStrings.howToPlayRapidTitle,
                  iconData: Icons.air_rounded,
                  iconColor: Colors.white,
                  info: AppStrings.howToPlayRapidInfo
              ),
              ExpandableHowToPlay(
                  title: AppStrings.howToPlayNinjaTitle,
                  iconData: Icons.flash_on,
                  iconColor: Colors.yellow,
                  info: AppStrings.howToPlayNinjaInfo
              ),
            ],
          ),
        ),
      ),
    );
  }
}
