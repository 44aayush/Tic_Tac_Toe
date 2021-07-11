import 'package:flutter/material.dart';
import 'package:xox/com/vscom.dart';
import 'package:xox/utils.dart';
import 'package:xox/player/vsplayer.dart';

void main() {
  runApp(XOX());
}

class XOX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[800],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Container(
                      child: Text(
                        "TIC TAC TOE",
                        style: kHeadingText,
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         style: BorderStyle.none,
                //       ),
                //       shape: BoxShape.circle,
                //     ),
                //     child: CircleAvatar(
                //       backgroundColor: Colors.grey[900],
                //       child: Container(
                //         child: Image.asset(
                //           'splash.png',
                //           color: Colors.white,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //       radius: 80.0,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 60.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VsCOMPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, right: 40.0, bottom: 60.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(30.0),
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'vs COM',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VsPlayerPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, right: 40.0, bottom: 60.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(30.0),
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'vs PLAYER 2',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
