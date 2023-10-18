import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import 'package:rapid_reaction/presentation/view_model/cubit.dart';
import '../../view_model/states.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit()..spawn(context.height, context.width),
      child: BlocBuilder<GameCubit, GameState>(
        builder: (cubitContext, state) {
         var cubit = GameCubit.get(cubitContext);
         return (state is GameLoadingState) ? const Scaffold() :
         Scaffold(
           body: Padding(
             padding: const EdgeInsets.all(AppValues.pagePadding),
             child: SizedBox(
               height: context.height - AppValues.pagePadding*2,
               width: context.width - AppValues.pagePadding*2,
               child: Stack(
                 children: [
                   Visibility(
                       visible: cubit.visible,
                       child: cubit.gameObject.getWidget(cubit.onHit)
                   )
                 ],
               ),
             ),
           ),
         );
        },
      ),
    );
  }
}