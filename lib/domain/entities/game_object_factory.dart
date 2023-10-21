import 'package:rapid_reaction/app/resources/app_assets.dart';
import 'package:rapid_reaction/app/resources/app_enums.dart';
import 'package:rapid_reaction/domain/entities/base_game_object.dart';
import 'package:rapid_reaction/domain/entities/ninja_game_object.dart';
import 'package:rapid_reaction/domain/entities/normal_game_object.dart';
import 'package:rapid_reaction/domain/entities/rapid_game_object.dart';

class GameObjectFactory {

  Future<GameObject> create(double h, double w, GameMode gameMode) async {
    if(gameMode == GameMode.normal) {
      const clickSound = AppAssets.normalHitSound;
      return await NormalGameObject.create(h, w, gameMode, clickSound);
    }
    else if(gameMode == GameMode.rapid) {
      const clickSound = AppAssets.normalHitSound;
      return await RapidGameObject.create(h, w, gameMode, clickSound);
    }
    else if(gameMode == GameMode.ninja) {
      const clickSound = AppAssets.ninjaHitSound;
      return await NinjaGameObject.create(h, w, gameMode, clickSound,
          AppAssets.showNinja);
    }
    else {

      throw Exception("Make sure you implement the Game Object At Factory");
    }
  }

}