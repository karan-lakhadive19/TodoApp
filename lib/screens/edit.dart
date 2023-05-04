// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/home.dart';

class EditTask extends StatefulWidget {

  EditTask({super.key,});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    final maxLines = 5;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Task",
          style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: titleController..text="${Get.arguments['title'].toString()}",
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
                  controller: descController..text="${Get.arguments['desc'].toString()}",
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
                    onPressed: () async{
                      FirebaseAuth auth = FirebaseAuth.instance;
                      final User? user = auth.currentUser;
                      String uid = user!.uid;
                      print(uid);
                      print(Get.arguments['time'].toString());
                     await FirebaseFirestore.instance.collection("task").doc(uid).collection('MyTask').doc(Get.arguments['time'].toString()).update({
                      'title':titleController.text.trim(),
                      'desc':descController.text.trim(),
                     });
                     const snackBar = SnackBar(
        content: Text(
          "Task Edited!",
          style: TextStyle(
            fontSize: 16, // adjust to your desired font size
            color: Colors.white, // set text color
          ),
        ),
        backgroundColor: Colors.purpleAccent, // set background color
        behavior: SnackBarBehavior.floating, // set the behavior to floating
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Text("Edit Task",
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
