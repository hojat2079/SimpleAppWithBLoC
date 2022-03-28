part of 'edit_task_cubit.dart';

@immutable
abstract class EditTaskState {
  final Task task;

  const EditTaskState(this.task);
}

class EditTaskInitial extends EditTaskState {
  const EditTaskInitial(Task task) : super(task);
}

class EditTaskPriorityChanged extends EditTaskState {
  const EditTaskPriorityChanged(Task task) : super(task);
}
