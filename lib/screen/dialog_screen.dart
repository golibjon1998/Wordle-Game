import 'package:flutter/material.dart';

class DialogPage extends StatelessWidget {
  final bool gameOver;
  final String answer;
  VoidCallback onRestart;

  DialogPage({Key? key, required this.onRestart, required this.gameOver, required this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              gameOver == true ? 'Game Over' : 'Congratulations 🎉✈',
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            const SizedBox(height: 16),
             Text(
              '"$answer"',
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green.shade400),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.green.shade400,width: 2.0)))),
                onPressed: onRestart,
                child: const Text(
                  "Play again",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),

            // const SizedBox(width: 8),

            // MaterialButton(child: Text("Play again"), onPressed: (){})
          ],
        ),
      ),
    );
  }
}
