import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _username = '';
  bool isLogin = false;

  // ************** Below code authenticate and add data to firestore database **************

  startAuth() {
    final _valid = _formKey.currentState!.validate();
    if (_valid) {
      _formKey.currentState!.save();

      isLogin ? signinUser(_email, _password) : signupUser(_email, _password);
    }
  }

  void signinUser(String _email, String _password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      const snackBar = SnackBar(
        content: Text(
          "Signed in Successfully",
          style: TextStyle(
            fontSize: 16, // adjust to your desired font size
            color: Colors.white, // set text color
          ),
        ),
        backgroundColor: Colors.blue, // set background color
        behavior: SnackBarBehavior.floating, // set the behavior to floating
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // print("Signed In Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const snackBar = SnackBar(
        content: Text(
          "'No user found for that email.'",
          style: TextStyle(
            fontSize: 16, // adjust to your desired font size
            color: Colors.white, // set text color
          ),
        ),
        backgroundColor: Colors.blue, // set background color
        behavior: SnackBarBehavior.floating, // set the behavior to floating
      );
        
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        const snackBar = SnackBar(
        content: Text(
          "Wrong password provided for that user.",
          style: TextStyle(
            fontSize: 16, // adjust to your desired font size
            color: Colors.white, // set text color
          ),
        ),
        backgroundColor: Colors.blue, // set background color
        behavior: SnackBarBehavior.floating, // set the behavior to floating
      );
       
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // print('Wrong password provided for that user.');
      }
    }
  }

  void signupUser(String _email, String _password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
          const snackBar = SnackBar(
        content: Text(
          "Signed up Successfully",
          style: TextStyle(
            fontSize: 16, // adjust to your desired font size
            color: Colors.white, // set text color
          ),
        ),
        backgroundColor: Colors.blue, // set background color
        behavior: SnackBarBehavior.floating, // set the behavior to floating
      );
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // print("Success");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': _username,
        'email': _email,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const snackBar = SnackBar(
        content: Text(
          'The password provided is too weak.',
          style: TextStyle(
            fontSize: 16, // adjust to your desired font size
            color: Colors.white, // set text color
          ),
        ),
        backgroundColor: Colors.blue, // set background color
        behavior: SnackBarBehavior.floating, // set the behavior to floating
      );
        
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
         const snackBar = SnackBar(
        content: Text(
          'The account already exists for that email.',
          style: TextStyle(
            fontSize: 16, // adjust to your desired font size
            color: Colors.white, // set text color
          ),
        ),
        backgroundColor: Colors.blue, // set background color
        behavior: SnackBarBehavior.floating, // set the behavior to floating
      );
        
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !isLogin
                        ? TextFormField(
                            keyboardType: TextInputType.text,
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 3) {
                                return 'Enter valid username';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _username = value!;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide()),
                                labelText: "Enter Username",
                                labelStyle: GoogleFonts.roboto()),
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email address';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              borderSide: new BorderSide()),
                          labelText: "Enter Email",
                          labelStyle: GoogleFonts.roboto()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect Password';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              borderSide: new BorderSide()),
                          labelText: "Enter Password",
                          labelStyle: GoogleFonts.roboto()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: isLogin
                              ? Text(
                                  "Login",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("Signup",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                          onPressed: () {
                            // startAuth();
                            startAuth();
                          },
                        )),
                    TextButton(
                      child: isLogin
                          ? Text(
                              "Don't have an account? Signup?",
                              style: GoogleFonts.roboto(fontSize: 16),
                            )
                          : Text(
                              "Already have an account? Login?",
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
