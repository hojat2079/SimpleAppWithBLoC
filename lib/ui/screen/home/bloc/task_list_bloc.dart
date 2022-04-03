import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bolc/data/data.dart';
import 'package:bolc/data/repository/repository_impl.dart';
import 'package:meta/meta.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final RepositoryImpl<Task> repository;

  TaskListBloc(this.repository) : super(TaskListInitial()) {
    on<TaskListEvent>((event, emit) async {
      if (event is TaskListSearch || event is TaskListStarted) {
        final String searchKeyboard;
        emit(TaskListLoading());
        if (event is TaskListSearch) {
          searchKeyboard = event.searchKeyboard;
        } else {
          searchKeyboard = '';
        }
        try {
          final items = await repository.getAll(searchKeyboard: searchKeyboard);
          if (items.isNotEmpty) {
            emit(TaskListSuccess(items));
          } else {
            emit(TaskListEmpty());
          }
        } catch (e) {
          emit(TaskListError('خطای نامشخص'));
        }
      } else if (event is TaskListDeleteAll) {
        await repository.deleteAll();
        emit(TaskListEmpty());
      }else if(event is TaskListDeleteItem){
        await repository.delete(event.task);
      }
    });
  }
}
