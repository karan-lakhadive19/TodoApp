// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  addTaskFirebase()async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // UserCredential userCredential = await FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String uid = user!.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance.collection('task').doc(uid).collection('MyTask').doc(time.toString()).set({
      'title':titleController.text,
      'desc':descController.text,
      'time':time.toString(),
      'timestamp':time
    });
    const snackBar = SnackBar(
        content: Text(
          "Task Added!",
          style: TextStyle(
            fontSize: 16, // adjust to your desired font size
            color: Colors.white, // set text color
          ),
        ),
        backgroundColor: Colors.blue, // set background color
        behavior: SnackBarBehavior.floating, // set the behavior to floating
      );
       
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  @override
  Widget build(BuildContext context) {
    final maxLines = 5;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Enter Title", border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                 height: maxLines * 24.0,
                child: TextField(
                  controller: descController,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                      hintText: "Enter Description",
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      addTaskFirebase();
                    },
                    child: Text("Add Task",
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
