import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  final String title, desc;
  const Description({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Description", style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold))),
      body: Container(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(title, style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(desc, style: GoogleFonts.roboto(fontSize: 18),),
          ),
        ],
      )),
    );
  }
}