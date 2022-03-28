import 'package:hive/hive.dart';
part 'data.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  int id = -1;
  @HiveField(0)
  bool isCompleted = false;
  @HiveField(1)
  String name = '';
  @HiveField(2)
  Priority priority = Priority.low;
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  normal,
  @HiveField(2)
  high
}
