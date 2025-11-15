// import 'package:firebase_backend/models/priority.dart';
// import 'package:firebase_backend/models/task.dart';
// import 'package:firebase_backend/services/priority.dart';
// import 'package:firebase_backend/services/task.dart';
// import 'package:firebase_backend/views/get_task.dart';
// import 'package:flutter/material.dart';
//
// import 'getalltask.dart';
//
// class CreateTask extends StatefulWidget {
//   const CreateTask({super.key});
//
//   @override
//   State<CreateTask> createState() => _CreateTaskState();
// }
//
// class _CreateTaskState extends State<CreateTask> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   bool isLoading = false;
//   List<PriorityModel> priorityList = [];
//   PriorityModel? _selectedPriority;
//
//   @override
//   @override
//   void initState() {
//     PriorityServices().getALlPriority().then((val){
//        priorityList = val! ;
//        setState(() {});
//     });
//
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Create Task"),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: Column(children: [
//         TextField(controller: titleController,),
//         TextField(controller: descriptionController,),
//         DropdownButton(
//             items: priorityList.map((e){
//               return DropdownMenuItem(value: e,child: Text(e.name.toString()));
//             }).toList(),
//             value: _selectedPriority,
//             isExpanded: true,
//             hint: Text("Select Priority"),
//             onChanged: (val){
//               _selectedPriority = val;
//               setState(() {});
//             }),
//         isLoading ? Center(child: CircularProgressIndicator(),):
//         ElevatedButton(onPressed: ()async{
//           try{
//             isLoading = true;
//             setState(() {});
//             await TaskServices()
//                 .createTask(TaskModel(
//               title: titleController.text.toString(),
//               description: descriptionController.text.toString(),
//               priorityID: _selectedPriority!.docId.toString(),
//               isCompleted: false,
//               createdAt: DateTime.now().millisecondsSinceEpoch,
//             )).then((val){
//               isLoading = false;
//               setState(() {});
//               return showDialog(context: context, builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text("Thank You"),
//                   content: Text("Create Successfully"),
//                   actions: [
//                     TextButton(onPressed: (){
//                       Navigator.pop(context);
//                     }, child: Text("Back")),
//                     TextButton(onPressed: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>GetAllTask()));
//                     }, child: Text("Next")),
//                   ],
//                 );
//               });
//             });
//           }
//               catch(e){
//             isLoading = false;
//             setState(() {});
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(e.toString()))
//             );
//               }
//         }, child: Text("Create Task"))
//       ],),
//     );
//   }
// }
