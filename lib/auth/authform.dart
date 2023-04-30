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
                        if (value!.isEmpty || value.contains('@')) {
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
                          child: isLogin ? Text("Login", style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),) : Text("Signup",style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {},
                        )),
                        TextButton(child: isLogin? Text("Don't have an account? Signup?", style: GoogleFonts.roboto(fontSize: 16),) : Text("Already have an account? Login?", style: GoogleFonts.roboto(fontSize: 16),) ,onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },)
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
