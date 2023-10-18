import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/components/app_title.dart';
import 'package:rapid_reaction/app/components/back_app_bar.dart';
import 'package:rapid_reaction/app/components/info_item.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_shared_prefs_keys.dart';
import 'package:rapid_reaction/app/resources/app_strings.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import 'package:rapid_reaction/presentation/view/scoreboard/components/scoreboard_score_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({Key? key}) : super(key: key);

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  List<int> reactionsHistory = [];


  @override
  void initState() {
    super.initState();
    getReactionsHistory();
  }

  Future getReactionsHistory() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final result=sharedPrefs.get(AppSharedPrefsKeys.reactionMsHistory) as List<String>? ?? [];
    setState(() {
      reactionsHistory.addAll(result.map((e) => int.parse(e)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    if(reactionsHistory.isNotEmpty) {
      return Scaffold(
        appBar: getBackAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(AppValues.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTitle(title: AppStrings.scoreboard),
              InfoItem(icon: Icons.star, title: AppStrings.bestScore,
                  info: AppStrings.getTimeString(reactionsHistory.max)),
              const SizedBox(height: AppValues.pagePadding),
              const AppTitle(title:AppStrings.lastGames),
              Expanded(
                child: ListView.builder(
                  itemCount: reactionsHistory.length,
                  itemBuilder: (context, index) => ScoreItem(index: index+1,
                      info: AppStrings.getTimeString(reactionsHistory[index]),
                      icon: Icons.timer_rounded),
                ),
              )
            ],
          ),
        ),
      );
    }
    else {
      return Scaffold(
        appBar: getBackAppBar(context),
        body: Center(
          child: Text(AppStrings.noScores, style: context.textTheme.titleLarge),
        ),
      );
    }
  }
}
