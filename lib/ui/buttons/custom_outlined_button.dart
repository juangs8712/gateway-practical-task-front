import 'package:flutter/material.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = Colors.blue,
    this.isFilled = false, 
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final Color color;
  final bool isFilled;
  final bool isLoading;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
            side: MaterialStateProperty.all(BorderSide(color: color)),
            backgroundColor: MaterialStateProperty.all(
                isFilled ? color.withOpacity(0.3) : Colors.transparent)),
        onPressed: isLoading? (){} : onPressed ,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isLoading? 5 : 20, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text( text, style: const TextStyle(fontSize: 16) ),
              if ( isLoading )
              ...[
                const SizedBox( width: 10,),
                const SizedBox(
                  width:  20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 1,))
              ]
            ],
          ),
        ));
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
