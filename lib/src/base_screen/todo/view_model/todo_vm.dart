// import 'dart:collection';
// import 'dart:developer';
//
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:todo/constant/enums.dart';
// import 'package:todo/services/firebase/collections.dart';
// import 'package:todo/src/base_screen/todo/model/tasks.dart';
// import 'package:todo/utils/helper.dart';
//
// class TodoVM extends ChangeNotifier {
//   Task? removedTask;
//
//   LoadingStateType loadingType = LoadingStateType.loaded;
//
//   TodoVM() {
//     loadData();
//   }
//
//   List<Task> _tasks = [];
//   UnmodifiableListView<Task> get tasks {
//     //we are creating getter as we set the main tasks to private.
//     // we did so , so that we remember that we can just add items
//     // to it using provider. we need to use the addTask method which
//     // we created.
//     return UnmodifiableListView(_tasks); //also the above is unmodifieable
//   }
//
//   int get tasksCount {
//     return _tasks.length;
//   }
//
//   // Future<void> addTask(String newTaskTitle) async {
//   //   try {
//   //     _changeLoaderState(LoadingStateType.loading);
//   //     final _task = Task(name: newTaskTitle, isDone: false);
//   //     DocumentReference documentReference = FBCollections.todos.doc();
//   //     await documentReference.set(_task.toMap());
//   //     _task.docRef = documentReference;
//   //     _tasks.add(_task);
//   //     Helper.showSnackBar("Addded the task Succesfully!");
//   //     _changeLoaderState(LoadingStateType.loaded);
//   //   } catch (e) {
//   //     _changeLoaderState(LoadingStateType.error);
//   //     log(e.toString());
//   //   }
//   // }
//
//   Future<void> updateTask(Task task) async {
//     try {
//       _changeLoaderState(LoadingStateType.loading);
//       await task.docRef!.update(task.toMap());
//       _changeLoaderState(LoadingStateType.loaded);
//     } catch (e) {
//       _changeLoaderState(LoadingStateType.error);
//       log(e.toString());
//     }
//   }
//
//   Future<void> deleteTask(Task task) async {
//     try {
//       await task.docRef!.delete();
//       _tasks.remove(task);
//       notifyListeners();
//       Helper.showSnackBar("Task deleted!");
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   Future<void> loadData() async {
//     _changeLoaderState(LoadingStateType.loading);
//
//     try {
//       var query = await FBCollections.todos.get();
//       log("message=>${query.docs.length}");
//       if (query.docs.isNotEmpty) {
//         _tasks = query.docs
//             .map((e) => Task.fromMap(e.data() as Map, e.reference))
//             .toList();
//       }
//       _changeLoaderState(LoadingStateType.loaded);
//     } catch (e) {
//       _changeLoaderState(LoadingStateType.error);
//       log(e.toString());
//     }
//   }
//
//   Future<void> deleteAll() async {
//     try {
//       _changeLoaderState(LoadingStateType.loading);
//       await Future.wait(List.generate(
//           _tasks.length, (index) => _tasks[index].docRef!.delete()));
//       Helper.showSnackBar("All task Deleted Succesfully ");
//       Get.back();
//       _tasks.clear();
//       _changeLoaderState(LoadingStateType.loaded);
//     } catch (e) {
//       _changeLoaderState(LoadingStateType.error);
//       log(e.toString());
//     }
//   }
//
//   void checkAll() {
//     for (var i = 0; i < _tasks.length; i++) {
//       _tasks[i].isDone = true;
//     }
//     notifyListeners();
//   }
//
//   void uncheckAll() {
//     for (var i = 0; i < _tasks.length; i++) {
//       _tasks[i].isDone = false;
//     }
//     notifyListeners();
//   }
//
//   void _changeLoaderState(LoadingStateType type) {
//     loadingType = type;
//     notifyListeners();
//   }
// }
