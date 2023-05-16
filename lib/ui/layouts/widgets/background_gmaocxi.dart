import 'package:flutter/material.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class BackgroundFondoPc extends StatelessWidget {
  const BackgroundFondoPc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset( 
      'assets/fondo-pc.jpeg',
      height: double.infinity,
      alignment: Alignment.centerRight,
      fit: BoxFit.fitHeight, );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~