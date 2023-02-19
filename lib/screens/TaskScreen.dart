import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_test/models/Task/Task.dart';
import 'package:webview_test/providers/diary_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  static const String routeName = '/task';

  static Route route({required Task task}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => TaskScreen(task: task));
  }

  final Task task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late VideoPlayerController _controller;
  bool isPlay = false;
  bool isLoading = false;
  String title = '';
  String desc = '';
  int week = 0;
  String videoUrl = '';
  List<Map<String, dynamic>> weeks = [
    {"title": "Mon", "id": 1},
    {"title": "Tue", "id": 2},
    {"title": "Wed", "id": 3},
    {"title": "Thu", "id": 4},
    {"title": "Fri", "id": 5},
    {"title": "Sat", "id": 6},
    {"title": "Sun", "id": 7},
  ];

  @override
  void initState() {
    super.initState();
    title = widget.task.title;
    desc = widget.task.desc;
    videoUrl = widget.task.videoUrl;
    week = widget.task.weekDay;

    if (videoUrl != '') {
      setState(() {
        isLoading = true;
      });
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((value) {
          setState(() {});
        });
      _controller.setLooping(true);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DiaryProvider diaryProvider = context.read<DiaryProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff1b2c57),
      appBar: AppBar(
        title: Text(widget.task.title),
        centerTitle: true,
        backgroundColor: const Color(0xff1b2c57),
        shadowColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                diaryProvider.deleteTask(widget.task);
                Navigator.pushNamed(context, '/tasks',
                    arguments: diaryProvider.diares
                        .firstWhere((element) => element.week == week)
                        .tasks);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          if (widget.task.id == 0) {
            if (week == 0 || title == 0) {
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return Container(
                        height: 100,
                        child: Center(
                            child:
                                Text('Please select week day and fill title')));
                  });
              return;
            }
            Task task = Task(
                diaryProvider.getNewIdTask(week), title, desc, videoUrl, week);
            diaryProvider.addTask(task);
            Navigator.pushNamed(context, '/tasks',
                arguments: diaryProvider.diares
                    .firstWhere((element) => element.week == week)
                    .tasks);
          } else {
            if (week == widget.task.weekDay) {
              diaryProvider.updateTask(
                  widget.task.id, week, title, desc, videoUrl);
            } else {
              Task task = Task(diaryProvider.getNewIdTask(week), title, desc,
                  videoUrl, week);
              diaryProvider.deleteTask(widget.task);
              diaryProvider.addTask(task);
            }
            Navigator.pushNamed(context, '/tasks',
                arguments: diaryProvider.diares
                    .firstWhere((element) => element.week == week)
                    .tasks);
          }
        },
        child: Text(widget.task.id == 0 ? 'Add' : 'Edit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 10),
                SizedBox(
                  height: 25,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weeks.length,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  week = weeks[index]['id'];
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 10,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: week == weeks[index]['id']
                                        ? Colors.orangeAccent
                                        : const Color.fromARGB(
                                            255, 14, 27, 58)),
                                child: Center(
                                    child: Text(
                                  weeks[index]['title'],
                                  style: TextStyle(
                                      color: week == weeks[index]['id']
                                          ? Colors.black
                                          : Colors.white),
                                )),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                videoUrl != ''
                    ? isLoading
                        ? SizedBox(
                            height: 30,
                            child: Center(child: CircularProgressIndicator()))
                        : Container(
                            child: _controller.value.isInitialized
                                ? Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPlay = false;
                                            _controller.pause();
                                          });
                                        },
                                        child: AspectRatio(
                                          aspectRatio:
                                              _controller.value.aspectRatio,
                                          child: VideoPlayer(_controller),
                                        ),
                                      ),
                                      !isPlay
                                          ? Positioned(
                                              top: 90,
                                              left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  30,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isPlay = true;
                                                    _controller.play();
                                                  });
                                                },
                                                child: !isPlay
                                                    ? Icon(
                                                        Icons.play_circle,
                                                        color: Colors.white,
                                                        size: 50,
                                                      )
                                                    : Icon(
                                                        Icons.stop_circle,
                                                        color: Colors.white,
                                                        size: 50,
                                                      ),
                                              ))
                                          : SizedBox()
                                    ],
                                  )
                                : Container(),
                          )
                    : SizedBox(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: const ValueKey('title'),
                    onChanged: (e) {
                      setState(() {
                        title = e;
                      });
                    },
                    initialValue: title,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        label: Text(
                          'Title',
                        ),
                        focusColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 114, 114, 114))),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextFormField(
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    key: const ValueKey('description'),
                    onChanged: (text) {
                      setState(() {
                        desc = text;
                      });
                    },
                    initialValue: desc,
                    style: TextStyle(color: Colors.white),
                    // cursorColor: textColorDark,
                    // obscureText: isObsured,
                    decoration: InputDecoration(
                        label: Text('Description'),
                        focusColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.white),
                        // focusedBorder: const OutlineInputBorder(
                        //   borderSide: BorderSide(color: textColorDark),
                        // ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 114, 114, 114))),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        suffixIconColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    key: const ValueKey('video'),
                    onChanged: (text) {
                      setState(() {
                        videoUrl = text;
                      });
                    },

                    // cursorColor: textColorDark,
                    // obscureText: isObsured,
                    initialValue: videoUrl,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        label: Text('Video url'),
                        alignLabelWithHint: false,
                        focusColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.white),
                        // focusedBorder: const OutlineInputBorder(
                        //   borderSide: BorderSide(color: textColorDark),
                        // ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 114, 114, 114))),
                        suffixIconColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
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
