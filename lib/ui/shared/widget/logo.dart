import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        const Icon( Icons.stream_outlined, color: Colors.white, ),

        const SizedBox( width: 10, ),
        Text('Gateway',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white
          ),
          )
      ],),
    );
  }
}