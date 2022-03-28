import 'package:bolc/data/data.dart';
import 'package:bolc/data/repository/repository_impl.dart';
import 'package:bolc/ui/colors.dart';
import 'package:bolc/ui/screen/edit/cubit/edit_task_cubit.dart';
import 'package:bolc/ui/screen/edit/edit.dart';
import 'package:bolc/ui/widget/customCheckbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  static const double taskItemHeight = 74;
  static const double taskItemRadius = 8;

  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Color priorityColor;
    switch (widget.task.priority) {
      case Priority.low:
        priorityColor = lowPriorityColor;
        break;
      case Priority.high:
        priorityColor = highPriorityColor;
        break;
      case Priority.normal:
        priorityColor = normalPriorityColor;
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TaskItem.taskItemRadius),
              color: themeData.colorScheme.surface,
              boxShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.05))
              ]),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onLongPress: () {
              final repo =
                  Provider.of<RepositoryImpl<Task>>(context, listen: false);
              repo.delete(widget.task);
            },
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider<EditTaskCubit>(
                  create: ((context) {
                    return EditTaskCubit(
                        widget.task, context.read<RepositoryImpl<Task>>());
                  }),
                  child: const AddNewTaskScreen(),
                );
              }));
            },
            child: Container(
              height: TaskItem.taskItemHeight,
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  CustomCheckBox(
                    value: widget.task.isCompleted,
                    onTap: () {
                      setState(() {
                        widget.task.isCompleted = !widget.task.isCompleted;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      widget.task.name,
                      style: TextStyle(
                          fontSize: 16,
                          decoration: widget.task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 5,
                    height: TaskItem.taskItemHeight,
                    decoration: BoxDecoration(
                        color: priorityColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(TaskItem.taskItemRadius),
                            bottomRight:
                                Radius.circular(TaskItem.taskItemRadius))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
