class AppStrings {

  static const play = "Play";
  static const gameModes = "Game Modes";
  static const scoreboard = "Scoreboard";
  static const howToPlay = "How to Play";
  static const gameOver = "Game Complete";
  static const tryAgain = "Try Again";
  static const reactionSpeed = "Reaction Speed";
  static const bestReaction = "Best Reaction";
  static const worstReaction = "Worst Reaction";
  static const done = "Done";
  static const bestScore = "Best Reaction";
  static const noScores = "No Scores to see yet";
  static const lastGames = "Last Games";
  static const normalMode = "Normal Mode";
  static const rapidMode = "Rapid Mode";
  static const ninjaMode = "Ninja Mode";
  static const pressNow = "Press Now!";
  static const restart = "Restart";

  static const howToPlayNormalTitle = "Normal Mode";
  static const howToPlayRapidTitle =  "Rapid Mode";
  static const howToPlayNinjaTitle =  "Ninja Mode";

  static const howToPlayNormalInfo = "In this mode, your goal is to test your reaction time. You'll wait a bit and then you will see a light blue screen with the text 'Press Now'. As soon as you see this message, tap the screen as quickly as possible. Your reaction time will be recorded, and this will repeat multiple times until the game is complete. Try to achieve the fastest reaction times to master this mode.";
  static const howToPlayRapidInfo = "In this mode, your mission is to tap the circles that appear on random positions of the screen as fast as possible. You'll need to be quick! Each time a circle appears, swiftly tap it to record your reaction time. This will continue to happen multiple times until the game is complete. Challenge yourself to tap each circle with lightning speed and improve your reaction time.";
  static const howToPlayNinjaInfo = "In this mode, you'll encounter circles that appear randomly on the screen. Your goal is to tap them as fast as possible to get a good reaction time. What's unique about this mode is that the size of the next circle depends on how quickly you tap the previous one. If you react quickly, the next circle will be bigger. If you react slowly, it will be smaller. Keep playing until the circle becomes so small that it's barely visible. Strive to maintain quick reactions to keep the circles growing!";


  static String getTimeString(int ms) => "$ms MS";
}