import 'package:bolc/data/data.dart';
import 'package:bolc/data/source/datasource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTaskLocalSource implements DataSource<Task> {
  final Box<Task> box;

  HiveTaskLocalSource(this.box);

  @override
  Future<Task> createOrUpdate(Task data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(Task data) {
    return data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteElementById({id}) {
    return box.delete(id);
  }

  @override
  Future<List<Task>> getAll({String searchKeyboard = ''}) async {
    return box.values
        .where((element) => element.name.contains(searchKeyboard))
        .toList();
  }

  @override
  Future<Task> getElementById({id}) async {
    return box.values.firstWhere((element) => element.id = id);
  }
}
