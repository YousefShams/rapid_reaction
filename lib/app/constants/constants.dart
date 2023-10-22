
class AppConsts {

  static const appTitle = "Rapid Reaction";
  static const splashTime = 4;
  static const circleGameObjectSize = 40.0;
  static const minCircleGameObjectSizeFactor = 0.2;
  static const minReactionDelayTime = 400;
  static const maxReactionDelayTime = 3000;
  static const minNormalDelayTime = 1000;
  static const maxNormalDelayTime = 6000;
  static const lowNinjaReactionTime = 700;
  static const highNinjaReactionTime = 1500;
  static const highNinjaReactionTimeNorm = highNinjaReactionTime-lowNinjaReactionTime;
  static const normalModeMaxHits = 10;
  static const rapidModeMaxHits = 15;
  static final percentIndicatorMs = ((1 - minCircleGameObjectSizeFactor)*
      highNinjaReactionTimeNorm).ceil() + lowNinjaReactionTime;

}