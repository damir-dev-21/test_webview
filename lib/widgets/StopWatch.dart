import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({
    Key? key,
  }) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  TimeOfDay? timeOfDay = TimeOfDay.now();
  bool play = false;
  int minutes = 1;
  int seconds = 0;
  int progresIndicator = 60;
  String time = "";

  Timer? timer;

  @override
  void initState() {
    time = "0${minutes.toString()}:00";

    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (((timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
          progresIndicator = seconds;
        }
        if (seconds == 0) {
          if (minutes > 0) {
            seconds = 59;

            minutes = minutes - 1;
          } else {
            stopTimer();
            minutes = 1;
            seconds = 0;
            progresIndicator = 60;
            play = false;
            time = "00:00";
          }
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
                value: progresIndicator / 60,
                strokeWidth: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    TimeOfDay? newTime = await showTimePicker(
                        context: context, initialTime: timeOfDay!);
                    if (newTime != null) {
                      setState(() {
                        timeOfDay = newTime;
                        minutes = newTime.minute;
                        seconds = 0;
                        time = "0${minutes.toString()}:00";
                      });
                    }
                  },
                  child: Text(
                    '${time.toString()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
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
                        progresIndicator = 60;
                        minutes = 1;
                        seconds = 0;
                        time = "01:00";
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
