import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xox/com/custom_dialog.dart';
import 'package:xox/com/game_button.dart';
import 'package:xox/utils.dart';

class VsCOMPage extends StatefulWidget {
  const VsCOMPage({Key? key}) : super(key: key);

  @override
  _VsCOMPageState createState() => _VsCOMPageState();
}

class _VsCOMPageState extends State<VsCOMPage> {
  late List<GameButton> buttonsList;
  var x;
  var o;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    x = [];
    o = [];
    activePlayer = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.red;
        activePlayer = 2;
        x.add(gb.id);
      } else {
        gb.text = "0";
        gb.bg = Colors.black;
        activePlayer = 1;
        o.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => new CustomDialog("Game Tied",
                  "Press the reset button to start again.", resetGame));
        } else {
          // ignore: unnecessary_statements
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = [];
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(x.contains(cellID) || o.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);
  }

  int checkWinner() {
    var winner = -1;
    if (x.contains(1) && x.contains(2) && x.contains(3)) {
      winner = 1;
    }
    if (o.contains(1) && o.contains(2) && o.contains(3)) {
      winner = 2;
    }

    // row 2
    if (x.contains(4) && x.contains(5) && x.contains(6)) {
      winner = 1;
    }
    if (o.contains(4) && o.contains(5) && o.contains(6)) {
      winner = 2;
    }

    // row 3
    if (x.contains(7) && x.contains(8) && x.contains(9)) {
      winner = 1;
    }
    if (o.contains(7) && o.contains(8) && o.contains(9)) {
      winner = 2;
    }

    // col 1
    if (x.contains(1) && x.contains(4) && x.contains(7)) {
      winner = 1;
    }
    if (o.contains(1) && o.contains(4) && o.contains(7)) {
      winner = 2;
    }

    // col 2
    if (x.contains(2) && x.contains(5) && x.contains(8)) {
      winner = 1;
    }
    if (o.contains(2) && o.contains(5) && o.contains(8)) {
      winner = 2;
    }

    // col 3
    if (x.contains(3) && x.contains(6) && x.contains(9)) {
      winner = 1;
    }
    if (o.contains(3) && o.contains(6) && o.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (x.contains(1) && x.contains(5) && x.contains(9)) {
      winner = 1;
    }
    if (o.contains(1) && o.contains(5) && o.contains(9)) {
      winner = 2;
    }

    if (x.contains(3) && x.contains(5) && x.contains(7)) {
      winner = 1;
    }
    if (o.contains(3) && o.contains(5) && o.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog(
                "X Won", "Press the reset button to start again.", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog(
                "O Won", "Press the reset button to start again.", resetGame));
      }
    }

    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Player X',
                            style: kTextStyle,
                          ),
                          Text(
                            x.toString(),
                            style: kTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Player O',
                            style: kTextStyle,
                          ),
                          Text(
                            o.toString(),
                            style: kTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                ),
                itemCount: buttonsList.length,
                itemBuilder: (context, i) => new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: buttonsList[i].bg,
                      padding: const EdgeInsets.all(8.0),
                      onSurface: buttonsList[i].bg,
                    ),
                    onPressed: buttonsList[i].enabled
                        ? () => playGame(buttonsList[i])
                        : null,
                    child: new Text(
                      buttonsList[i].text,
                      style: new TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: const EdgeInsets.all(20.0),
              ),
              child: new Text(
                "Reset",
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: resetGame,
            )
          ],
        ));
  }
}
//           children: <Widget>[
//             new Expanded(
//               child: new GridView.builder(
//                 padding: const EdgeInsets.all(10.0),
//                 gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     childAspectRatio: 1.0,
//                     crossAxisSpacing: 9.0,
//                     mainAxisSpacing: 9.0),
//                 itemCount: buttonsList.length,
//                 itemBuilder: (context, i) => new SizedBox(
//                   width: 100.0,
//                   height: 100.0,
//                   child: RaisedButton(
//                     padding: const EdgeInsets.all(8.0),
//                     onPressed: buttonsList[i].enabled
//                         ? () => playGame(buttonsList[i])
//                         : null,
//                     child: new Text(
//                       buttonsList[i].text,
//                       style: new TextStyle(color: Colors.white, fontSize: 20.0),
//                     ),
//                     color: buttonsList[i].bg,
//                     disabledColor: buttonsList[i].bg,
//                   ),
//                 ),
//               ),
//             ),
//             new RaisedButton(
//               child: new Text(
//                 "Reset",
//                 style: new TextStyle(color: Colors.white, fontSize: 20.0),
//               ),
//               color: Colors.red,
//               padding: const EdgeInsets.all(20.0),
//               onPressed: resetGame,
//             )
//           ],
//         ));
//   }
// }
