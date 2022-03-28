import 'package:bloc/bloc.dart';
import 'package:bolc/data/data.dart';
import 'package:bolc/data/repository/repository_impl.dart';
import 'package:meta/meta.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  final Task task;
  final RepositoryImpl<Task> repository;

  EditTaskCubit(this.task, this.repository) : super(EditTaskInitial(task));

  void onTextChanged(String text) {
    task.name = text;
  }

  void onChangePriority(Priority priority) {
    task.priority = priority;
    emit(EditTaskPriorityChanged(task));
  }

  void onSaveButtonClicked() {
    repository.createOrUpdate(task);
  }
}
