import 'dart:async';

import 'package:flutter/material.dart';

class timer extends StatefulWidget {
  const timer({
    Key? key,
  }) : super(key: key);

  @override
  State<timer> createState() => _timerState();
}

class _timerState extends State<timer> {
  String time = "00:00";
  bool play = false;
  int minutes = 0;
  int seconds = 0;

  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (((timer) {
      setState(() {
        seconds++;
        if (seconds == 60) {
          minutes = minutes + 1;
          seconds = 0;
        }
        if (minutes.toString().length == 2) {
          time = "${minutes}:${seconds}";
        } else if (seconds.toString().length == 2 &&
            minutes.toString().length == 1) {
          time = "0${minutes}:${seconds}";
        } else {
          time = "0${minutes}:0${seconds}";
        }
      });
    })));
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Stack(fit: StackFit.expand, children: [
              CircularProgressIndicator(
                color: Colors.orangeAccent,
                value: seconds / 60,
                strokeWidth: 10,
              ),
              Center(
                child: Text(
                  '${time.toString()}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        stopTimer();
                        play = false;
                        minutes = 0;
                        seconds = 0;
                        time = "00:00";
                      });
                    },
                    icon: Icon(
                      Icons.stop_circle,
                      size: 40,
                      color: Colors.orangeAccent,
                    )),
              ),
              IconButton(
                  onPressed: () {
                    if (play) {
                      stopTimer();
                    } else {
                      startTimer();
                    }
                    setState(() {
                      play = !play;
                    });
                  },
                  icon: Icon(
                    play ? Icons.pause_circle : Icons.play_circle,
                    size: 60,
                    color: Colors.orangeAccent,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
