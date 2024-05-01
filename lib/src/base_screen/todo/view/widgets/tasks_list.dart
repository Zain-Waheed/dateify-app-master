// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo/src/base_screen/todo/view/widgets/tasks_tile.dart';
// import 'package:todo/src/base_screen/todo/view_model/todo_vm.dart';
//
// class TasksWidget extends StatefulWidget {
//   @override
//   _TasksWidgetState createState() => _TasksWidgetState();
// }
//
// class _TasksWidgetState extends State<TasksWidget> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, taskdata, child) {
//         if (taskdata.tasks.isEmpty) {
//           return Center(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("No Todo Items Found hit + to add!"),
//               TextButton(
//                   onPressed: () {
//                     taskdata.loadData();
//                   },
//                   child: const Text("Retry")),
//             ],
//           ));
//         } else {
//           return GridView.builder(
//             physics:
//                 BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//             reverse: false,
//             itemCount: taskdata.tasks.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//
//             // ListView.builder(
//             //   padding: EdgeInsets.only(top: 15),
//             //   physics: BouncingScrollPhysics(
//             //       parent: AlwaysScrollableScrollPhysics()),
//             //   reverse: false,
//             itemBuilder: (context, index) {
//               return Dismissible(
//                 direction: DismissDirection.horizontal,
//                 key: UniqueKey(),
//                 background: Container(
//                   margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
//                   color: Colors.red,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 30),
//                         child: Icon(
//                           Icons.delete,
//                           size: 30,
//                         ),
//                       ),
//                       Text(
//                         "Delete ?",
//                         style: TextStyle(),
//                       ),
//                     ],
//                   ),
//                 ),
//                 secondaryBackground: Container(
//                   margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
//                   color: Colors.red,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const Text(
//                         "Delete ?",
//                         style: TextStyle(),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: const Icon(
//                           Icons.delete,
//                           size: 30,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onDismissed: (direction) {
//                   taskdata.deleteTask(taskdata.tasks[index]);
//                   // BotToast.showSimpleNotification(
//                   //   title: "To Do List 📝",
//                   //   subTitle: 'Deleted the task Succesfully',
//                   //   borderRadius: 10.0,
//                   // );
//                 },
//                 child: TaskTile(
//                   taskTitle: taskdata.tasks[index].name,
//                   isTrue: taskdata.tasks[index].isDone,
//                   longpresscallback: () {
//                     taskdata.deleteTask(taskdata.tasks[index]);
//                     // BotToast.showSimpleNotification(
//                     //   title: "To Do List 📝",
//                     //   subTitle: 'Deleted the task Succesfully',
//                     //   borderRadius: 10.0,
//                     // );
//                   },
//                   checkBoxCallBack: (checkBoxState) {
//                     taskdata.tasks[index].isDone =
//                         !taskdata.tasks[index].isDone;
//                     taskdata.updateTask(taskdata.tasks[index]);
//                   },
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
