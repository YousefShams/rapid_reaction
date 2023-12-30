import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_reaction/app/components/blur_animated_background.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import 'package:rapid_reaction/presentation/view/game/components/black_layer.dart';
import 'package:rapid_reaction/presentation/view_model/game_view_model/cubit.dart';
import '../../view_model/game_view_model/states.dart';
import 'components/tap_outside_detector.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit()..init(context.height, context.width),
      child: BlocBuilder<GameCubit, GameState>(
        builder: (cubitContext, state) {
         var cubit = GameCubit.get(cubitContext);
         return (state is GameLoadingState) ? const Scaffold() :
         Scaffold(
           body: Stack(
             children: [
               const BlurAnimation(),
               const BlackLayer(),
               TapOutsideDetector(onTap : cubit.onTapOutside),
               ...cubit.gameObject.scoreWidgets,
               Padding(
                 padding: const EdgeInsets.all(AppValues.pagePadding),
                 child: SizedBox(
                   height: context.height - AppValues.pagePadding*2,
                   width: context.width - AppValues.pagePadding*2,
                   child: Stack(
                     children: [
                       cubit.gameObject.getWidget(cubit.onHit)
                     ],
                   ),
                 ),
               )
             ],
           ),
         );
        },
      ),
    );
  }
}
