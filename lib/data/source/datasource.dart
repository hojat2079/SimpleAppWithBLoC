abstract class DataSource<T> {
  Future<List<T>> getAll({String searchKeyboard});

  Future<T> getElementById({dynamic id});

  Future<void> deleteElementById({dynamic id});

  Future<void> delete(T data);

  Future<void> deleteAll();

  Future<T> createOrUpdate(T data);
}
