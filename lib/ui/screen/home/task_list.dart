import 'package:bolc/data/data.dart';
import 'package:bolc/data/repository/repository_impl.dart';
import 'package:bolc/ui/colors.dart';
import 'package:bolc/ui/screen/home/bloc/task_list_bloc.dart';
import 'package:bolc/ui/screen/home/task_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.itemList,
    required this.themeData,
  }) : super(key: key);

  final List<Task> itemList;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: itemList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: themeData.textTheme.headline6!
                          .apply(fontSizeFactor: 0.9),
                    ),
                    Container(
                      height: 3,
                      width: 60,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: themeData.colorScheme.primary,
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                    )
                  ],
                ),
                MaterialButton(
                  onPressed: () {
                    context.read<TaskListBloc>().add(TaskListDeleteAll());
                  },
                  elevation: 0,
                  color: const Color(0xffeaeff5),
                  textColor: secondaryTextColor,
                  child: Row(
                    children: const [
                      Text('Delete All'),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        CupertinoIcons.delete_solid,
                        size: 18,
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            final task = itemList[index - 1];
            return TaskItem(task: task);
          }
        });
  }
}
