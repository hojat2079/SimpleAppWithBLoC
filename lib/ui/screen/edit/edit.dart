import 'package:bolc/data/data.dart';
import 'package:bolc/ui/colors.dart';
import 'package:bolc/ui/screen/edit/cubit/edit_task_cubit.dart';
import 'package:bolc/ui/screen/edit/priority_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<EditTaskCubit>().state.task.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
        elevation: 0,
        title: const Text('Edit Task'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          context.read<EditTaskCubit>().onSaveButtonClicked();
          Navigator.pop(context);
        },
        label: Row(
          children: const [
            Text('Save Changes'),
            SizedBox(
              width: 2,
            ),
            Icon(CupertinoIcons.checkmark_alt)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            BlocBuilder<EditTaskCubit, EditTaskState>(
              builder: (context, state) {
                final priority = state.task.priority;
                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                        flex: 1,
                        child: PriorityItem(
                          title: 'High',
                          isChecked: priority == Priority.high,
                          color: highPriorityColor,
                          onTap: () {
                            context
                                .read<EditTaskCubit>()
                                .onChangePriority(Priority.high);
                          },
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        flex: 1,
                        child: PriorityItem(
                          title: 'Normal',
                          isChecked: priority == Priority.normal,
                          color: normalPriorityColor,
                          onTap: () {
                            context
                                .read<EditTaskCubit>()
                                .onChangePriority(Priority.normal);
                          },
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        flex: 1,
                        child: PriorityItem(
                          title: 'Low',
                          isChecked: priority == Priority.low,
                          color: lowPriorityColor,
                          onTap: () {
                            context
                                .read<EditTaskCubit>()
                                .onChangePriority(Priority.low);
                          },
                        ))
                  ],
                );
              },
            ),
            TextField(
              controller: _controller,
              onChanged: (text) {
                context.read<EditTaskCubit>().onTextChanged(text);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Text(
                  'Add a task for today...',
                  style: TextStyle(
                      color: themeData.colorScheme.onSurface, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
