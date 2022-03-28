part of 'task_list_bloc.dart';

@immutable
abstract class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListSuccess extends TaskListState {
  final List<Task> tasks;

  TaskListSuccess(this.tasks);
}

class TaskListEmpty extends TaskListState {}

class TaskListError extends TaskListState {
  final String message;

  TaskListError(this.message);
}
