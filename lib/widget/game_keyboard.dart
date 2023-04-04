import 'package:flutter/material.dart';
import 'package:wordle_game/screen/dialog_screen.dart';
import 'package:wordle_game/widget/game_board.dart';

import '../util/game_provider.dart';

class GameKeyboard extends StatefulWidget {
  GameKeyboard(this.game, {Key? key}) : super(key: key);
  WordleGame game;

  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  List row1 = "QWERTYUIOP".split("");
  List row2 = "ASDFGHJKL".split("");
  List row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

  bool isShownAlert = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          WordleGame.game_message,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 20.0),
        GameBoard(widget.game),
        SizedBox(height: 40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row1.map((e) {
            return InkWell(
              onTap: () {
                // if (!isShownAlert) {
                print(e);
                if (widget.game.letterId < 5) {
                  setState(() {
                    widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                    widget.game.letterId++;
                  });
                }
                // }
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  '$e',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row2.map((e) {
            return InkWell(
              onTap: () {
                // if (!isShownAlert) {
                print(e);
                if (widget.game.letterId < 5) {
                  setState(() {
                    widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                    widget.game.letterId++;
                  });
                }
                // }
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  '$e',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row3.map((e) {
            return InkWell(
              // autofocus: true,
              onTap: () {
                print(e);
                if (e == "DEL") {
                  if (widget.game.letterId > 0) {
                    setState(() {
                      widget.game
                          .insertWord(widget.game.letterId - 1, Letter("", 0));
                      widget.game.letterId--;
                    });
                  }
                } else if (e == "SUBMIT") {
                  if (widget.game.rowId == 5) {
                    widget.game.rowId--;
                    print("JOY QOLMADI");
                    unpressedAllBtn();

                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return DialogPage(
                              onRestart: startNewGame,
                              gameOver: true,
                              answer: WordleGame.game_guess);
                        });
                    isShownAlert = true;
                  }
                  if (widget.game.letterId >= 5) {
                    String guess = widget.game.wordBoard[widget.game.rowId]
                        .map((e) => e.letter)
                        .join();

                    print('GUESS: $guess');
                    print('GAME_GUESS: ${WordleGame.game_guess}');
                    if (widget.game.checkWordExist(guess)) {
                      if (guess == WordleGame.game_guess.toUpperCase()) {
                        setState(() {
                          WordleGame.game_message = "Congratulations 🎉✈️";
                          widget.game.wordBoard[widget.game.rowId]
                              .forEach((element) {
                            element.code = 1;
                          });
                        });
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return DialogPage(
                                  onRestart: startNewGame,
                                  gameOver: false,
                                  answer: WordleGame.game_guess);
                            });
                        isShownAlert = true;
                      } //win
                      else {
                        var letter =
                            Letter(WordleGame.game_guess.toUpperCase(), 0);
                        int listLength = guess.length;
                        for (int i = 0; i < listLength; i++) {
                          String char = guess[i];
                          //letter.letter = Tough
                          // var list = letter.letter!.characters.toList();
                          // if (widget.game.wordBoard[widget.game.rowId][i].code != 1)
                          if (WordleGame.game_guess.toUpperCase().contains(char)) {
                          // if (letter.letter!.contains(char)) {
                            if (WordleGame.game_guess.toUpperCase()[i] == char) {
                            // if (letter.letter![i] == char) {
                              //must write this

                              setState(() {
                                widget.game.wordBoard[widget.game.rowId][i]
                                    .code = 1;
                              });
                            } else {
                              setState(() {
                                widget.game.wordBoard[widget.game.rowId][i]
                                    .code = 2;
                              });
                            }
                          }
                        }
                        setState(() {
                          WordleGame.game_message = "";
                        });
                        widget.game.rowId++;
                        widget.game.letterId = 0;
                        if (widget.game.rowId == 5) {
                          widget.game.rowId--;
                          print("JOY QOLMADI");
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return DialogPage(
                                    onRestart: startNewGame,
                                    gameOver: true,
                                    answer: WordleGame.game_guess);
                              });
                          isShownAlert = true;
                        }
                      }
                    } else {
                      setState(() {
                        WordleGame.game_message =
                            "the word does not exist try again";
                      });
                    }
                  }
                } else {
                  if (widget.game.letterId < 5) {
                    setState(() {
                      widget.game
                          .insertWord(widget.game.letterId, Letter(e, 0));
                      widget.game.letterId++;
                    });
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  '$e',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void startNewGame() {
    print("ROW_ID ${widget.game.rowId}");
    print("ROW_ID ${widget.game.letterId}");
    setState(() {
      for (int i = widget.game.rowId; i >= 0; i--) {
        widget.game.wordBoard[i].forEach((element) {
          element.code = 0;
          element.letter = "";
        });
      }

      widget.game.letterId = 0;
      widget.game.rowId = 0;
      widget.game.initGame();
      WordleGame.game_message = "";
      // widget.game.gameOver = true;
    });

    Navigator.of(context).pop();
  }

  void unpressedAllBtn() {}
}
