import 'package:hive_flutter/hive_flutter.dart';

part 'Task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String desc;
  @HiveField(3)
  late String videoUrl;
  @HiveField(4)
  late int weekDay;

  Task(this.id, this.title, this.desc, this.videoUrl, this.weekDay);
}
