import 'package:hive/hive.dart';
import 'package:webview_test/models/Task/Task.dart';

part 'Diary.g.dart';

@HiveType(typeId: 1)
class Diary {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int week;
  @HiveField(2)
  final List<Task> tasks;

  Diary(this.id, this.week, this.tasks);

  static getDiaryDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        break;
    }
  }
}
