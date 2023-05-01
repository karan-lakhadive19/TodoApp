// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
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
                    onPressed: () {},
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
