import 'package:bolc/data/data.dart';
import 'package:bolc/data/repository/repository_impl.dart';
import 'package:bolc/ui/screen/edit/cubit/edit_task_cubit.dart';
import 'package:bolc/ui/screen/edit/edit.dart';
import 'package:bolc/ui/screen/home/bloc/task_list_bloc.dart';
import 'package:bolc/ui/screen/home/task_list.dart';
import 'package:bolc/ui/widget/empty_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String> valueNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return BlocProvider<EditTaskCubit>(
                create: ((context) {
                  return EditTaskCubit(
                      Task(), context.read<RepositoryImpl<Task>>());
                }),
                child: const AddNewTaskScreen(),
              );
            }));
          },
          label: Row(children: const [
            Text('Add New Task'),
            SizedBox(
              width: 2,
            ),
            Icon(
              Icons.add,
              size: 24,
            )
          ]),
        ),
        body: BlocProvider<TaskListBloc>(
          create: (context) =>
              TaskListBloc(context.read<RepositoryImpl<Task>>()),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      themeData.colorScheme.primary,
                      themeData.colorScheme.primaryContainer
                    ],
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'To Do List',
                              style: themeData.textTheme.headline6!.apply(
                                  color: themeData.colorScheme.onPrimary),
                            ),
                            Icon(
                              CupertinoIcons.share,
                              color: themeData.colorScheme.onPrimary,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 38,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(19),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20),
                              ]),
                          child: Builder(builder: (context) {
                            return TextField(
                              onChanged: (text) {
                                context
                                    .read<TaskListBloc>()
                                    .add(TaskListSearch(text));
                              },
                              controller: controller,
                              decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  label: Text('Search Tasks...'),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(CupertinoIcons.search)),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<RepositoryImpl<Task>>(
                    builder: ((context, value, child) {
                      context
                          .read<TaskListBloc>()
                          .add(TaskListSearch(controller.text));
                      return BlocBuilder<TaskListBloc, TaskListState>(
                          builder: (context, state) {
                        if (state is TaskListSuccess) {
                          return ListItem(
                              itemList: state.tasks, themeData: themeData);
                        } else if (state is TaskListEmpty) {
                          return const EmptyState(
                            title: 'Your task list is empty',
                            imagePath: 'assets/empty_state.svg',
                          );
                        } else if (state is TaskListError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 18),
                            ),
                          );
                        } else if (state is TaskListLoading ||
                            state is TaskListInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          throw Exception('not valid State');
                        }
                      });
                    }),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
