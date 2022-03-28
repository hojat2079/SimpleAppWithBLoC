import 'package:bolc/data/repository/repository.dart';
import 'package:bolc/data/source/datasource.dart';
import 'package:flutter/cupertino.dart';


class RepositoryImpl<T> extends ChangeNotifier implements Repository<T> {
  DataSource<T> localDataSource;

  RepositoryImpl(this.localDataSource);

  @override
  Future<T> createOrUpdate(T data) async {
    final T addItem = await localDataSource.createOrUpdate(data);
    notifyListeners();
    return addItem;
  }

  @override
  Future<void> delete(T data) async {
    await localDataSource.delete(data);
    notifyListeners();
  }

  @override
  Future<void> deleteAll() async {
    await localDataSource.deleteAll();
    notifyListeners();
  }

  @override
  Future<void> deleteElementById({id}) {
    return localDataSource.deleteElementById(id: id);
  }

  @override
  Future<List<T>> getAll({String searchKeyboard = ''}) {
    return localDataSource.getAll(searchKeyboard: searchKeyboard);
  }

  @override
  Future<T> getElementById({id}) {
    return localDataSource.getElementById(id: id);
  }
}
