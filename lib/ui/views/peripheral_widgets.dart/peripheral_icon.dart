import 'package:flutter/material.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class PeripheralIcon extends StatelessWidget {
  const PeripheralIcon({
    super.key, required this.index,
  });

  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.black12,
          child: Icon( 
            Icons.airplay, 
            color: Colors.black54,)),
        
        Positioned(
          right: 2,
          bottom: 2,
          child: Container(
            width:  12,
            height: 12,
            alignment: Alignment.center,
            decoration: _builDecoration(),
            child: Text( 
              index.toString(), 
              style: const TextStyle( 
                color: Colors.white, 
                fontSize: 9 ), )),
        )
      ],
    );
  }
  // -----------------------------------------------------
  BoxDecoration _builDecoration() => const BoxDecoration(
    color: Colors.pinkAccent,
    shape: BoxShape.circle
  );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~