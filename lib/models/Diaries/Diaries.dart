import 'package:hive/hive.dart';
import 'package:webview_test/models/Diary/Diary.dart';

part 'Diaries.g.dart';

@HiveType(typeId: 2)
class Diaries extends HiveObject {
  @HiveField(0)
  late List<Diary> diaries;

  Diaries(this.diaries);
}
