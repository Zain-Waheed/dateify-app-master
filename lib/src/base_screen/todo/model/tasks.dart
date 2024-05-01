//
//
// class Task {
//   late String name;
//   late bool isDone;
//   // DocumentReference? docRef;
//   Task({required this.name, required this.isDone, this.docRef});
//   void toggleDone() {
//     isDone = !isDone;
//   }
//
//   Task.fromMap(Map map, DocumentReference documentReference)
//       : name = map['name'],
//         isDone = map['isDone'],
//         docRef = documentReference;
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'isDone': isDone,
//     };
//   }
// }
