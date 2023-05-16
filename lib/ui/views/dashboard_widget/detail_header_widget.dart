import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class DetailHeaderWidget extends StatelessWidget {
  const DetailHeaderWidget({
    super.key, 
    required this.child
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 50,
      alignment: Alignment.center,
      decoration: _buildDecoration(),
      margin: const EdgeInsets.all( 10 ),
      padding: const EdgeInsets.all( 5 ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon( Icons.device_hub_outlined),
              const SizedBox( width: 10,),
              Text( 
                'Gateway Details', 
                style: GoogleFonts.poppins( 
                  fontSize: 22, 
                  fontWeight: FontWeight.w500 ), ),
            ],
          ),
          const Divider(),
          child
        ],
      ),
    );
  }

  // -----------------------------------------------------
  BoxDecoration _buildDecoration() => BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity( 0.1 ),
        offset: const Offset( 1, 2),
        blurRadius: 1
      )
    ],
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:[
        Color(0xFFDFDFDF),
        Color(0xFFD8D8D8)
      ] ),
    borderRadius: BorderRadius.circular( 9 )
  );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
