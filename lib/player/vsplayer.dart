import 'package:flutter/material.dart';
import 'package:xox/utils.dart';

class VsPlayerPage extends StatefulWidget {
  @override
  _VsPlayerPageState createState() => _VsPlayerPageState();
}

class _VsPlayerPageState extends State<VsPlayerPage> {
  List<String> displayExOh = ['', '', '', '', '', '', '', '', ''];
  bool ohTurn = true;
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'x';
        filledBoxes += 1;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'o';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //check 1st row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showDialog(displayExOh[0]);
    }

    //check 2nd row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showDialog(displayExOh[3]);
    }

    //check 3rd row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showDialog(displayExOh[6]);
    }

    //check 1st column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showDialog(displayExOh[0]);
    }

    //check 2nd column
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showDialog(displayExOh[1]);
    }

    //check 3rd column
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showDialog(displayExOh[2]);
    }

    //check diagonal
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showDialog(displayExOh[0]);
    }

    //check diagonal
    if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      _showDialog(displayExOh[6]);
    }

    //Draw
    else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Draw'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _reset();
                Navigator.of(context).pop();
              },
              child: Text(
                'Play Again!',
                style: kDialogTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Winner is ' + winner),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _reset();
                Navigator.of(context).pop();
              },
              child: Text(
                'Play Again!',
                style: kDialogTextStyle,
              ),
            ),
          ],
        );
      },
    );
    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
  }

  void _reset() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });
    filledBoxes = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X',
                          style: kTextStyle,
                        ),
                        Text(
                          exScore.toString(),
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O',
                          style: kTextStyle,
                        ),
                        Text(
                          ohScore.toString(),
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
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        displayExOh[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
