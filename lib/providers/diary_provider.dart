import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:webview_test/models/Diaries/Diaries.dart';
import 'package:webview_test/models/Diary/Diary.dart';
import 'package:webview_test/models/Task/Task.dart';

class DiaryProvider extends ChangeNotifier {
  Box<Diaries> getDiariesFromDb() => Hive.box<Diaries>('diaries');
  final List<Diary> diares = [];

  Future<void> getStatus() async {
    final diariesDb = getDiariesFromDb().get('diaries');
    if (diariesDb != null) {
      diariesDb.diaries.forEach((e) {
        diares.add(e);
      });

      notifyListeners();
    } else {
      getDiariesFromDb().delete('diaries');
    }
    sortDiaries();
  }

  void setDiariesDb() {
    getDiariesFromDb().delete('diaries');
    getDiariesFromDb().put('diaries', Diaries(diares));
  }

  void sortDiaries() {
    diares.sort((a, b) => a.week - b.week);
  }

  void addTask(Task task) {
    final findedDiary = diares.firstWhere((e) => e.week == task.weekDay,
        orElse: () => Diary(0, 0, []));

    if (findedDiary.id == 0) {
      diares.add(Diary(diares.length + 1, task.weekDay, [task]));
    } else {
      findedDiary.tasks.add(task);
    }
    setDiariesDb();
    sortDiaries();
    notifyListeners();
  }

  void deleteTask(Task task) {
    final findedDiary =
        diares.firstWhere((element) => element.week == task.weekDay);
    findedDiary.tasks.removeWhere((e) => e.id == task.id);
    if (findedDiary.tasks.length == 0) {
      diares.removeWhere((element) => element.week == findedDiary.week);
    }
    setDiariesDb();
    sortDiaries();
    notifyListeners();
  }

  void updateTask(
      int id, int weekDay, String title, String desc, String videoUrl) {
    final findedDiary = diares.firstWhere((element) => element.week == weekDay);
    final findedTask =
        findedDiary.tasks.firstWhere((element) => element.id == id);
    findedTask.title = title;
    findedTask.desc = desc;
    findedTask.videoUrl = videoUrl;
    setDiariesDb();
    sortDiaries();
    notifyListeners();
  }

  int getNewIdTask(int weekDay) {
    final diary = diares.firstWhere((element) => element.week == weekDay,
        orElse: () => Diary(0, 0, []));
    return diary.id == 0 ? 1 : diary.tasks.length + 1;
  }

  int getNewIdDiary(int weekDay) {
    return diares.length + 1;
  }
}
