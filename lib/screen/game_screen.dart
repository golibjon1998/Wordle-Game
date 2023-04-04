import 'package:flutter/material.dart';
import 'package:wordle_game/util/game_provider.dart';
import 'package:wordle_game/widget/game_keyboard.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  WordleGame _game = WordleGame();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _game.initGame();
  }


  @override
  Widget build(BuildContext context) {
    // if(_game.gameOver) _game = WordleGame();
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Wordle',
            style: TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          GameKeyboard(_game)
        ],
      ),
    );
  }
}
