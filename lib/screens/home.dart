import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/addTask.dart';
import 'package:todo_app/screens/desc.dart';
import 'package:get/get.dart';
import 'edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = '';
  @override
  void initState() {
    // TODO: implement initState
    getUid();
    super.initState();
  }

  // Code to get user id

  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Todos', style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

// Retrieving data from firestore

        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('task')
              .doc(uid)
              .collection('MyTask')
              .snapshots(),
          builder: (context, snapshot) {

           

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docu = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docu.length,
                itemBuilder: (context, index) {
                  var t = snapshot.data!.docs[index]['time'];
                  var title = snapshot.data!.docs[index]['title'];
                  var desc = snapshot.data!.docs[index]['desc'];
                  return InkWell(
                    onTap: () {
                      
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(title: docu[index]['title'], desc: docu[index]['desc'])));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.purple[400],
                          borderRadius: BorderRadius.circular(10)),
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  docu[index]['title'],
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Container(
                                
                              // )
                            ],
                          ),
                          SizedBox(width: 100,),
                          Container(
                           
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                    ()=>EditTask(),
                                    arguments: {
                                      'title':title,
                                      'desc':desc,
                                      'time':t
                                    }
                                  );
                                
                              },
                              child: Icon(Icons.edit, color: Colors.white,),
                            ),
                          ),
                          Container(
                           
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('task')
                                    .doc(uid)
                                    .collection('MyTask')
                                    .doc(docu[index]['time'])
                                    .delete();
                              },
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        backgroundColor: Colors.purple,
      ),
    );
  }
}
