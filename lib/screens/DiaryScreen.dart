import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_test/models/Diary/Diary.dart';
import 'package:webview_test/models/Task/Task.dart';
import 'package:webview_test/providers/diary_provider.dart';

class DiaryList extends StatefulWidget {
  DiaryList({Key? key}) : super(key: key);
  static const String routeName = '/diaries';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => DiaryList());
  }

  @override
  State<DiaryList> createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  @override
  Widget build(BuildContext context) {
    DiaryProvider diaryProvider = Provider.of<DiaryProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xff1b2c57),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.pushNamed(context, '/task',
              arguments: Task(0, '', '', '', 0));
        },
        child: Text('Add'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: diaryProvider.diares.length,
            itemBuilder: (ctx, index) {
              final Diary diary = diaryProvider.diares[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/tasks',
                      arguments: diary.tasks);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 14, 27, 58),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    title: Text(Diary.getDiaryDay(diary.week)),
                    trailing: IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_right)),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
