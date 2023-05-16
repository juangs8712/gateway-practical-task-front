import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key, 
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text( 'Status: ' ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric( horizontal: 5 ),
          decoration: _buildDecoration(),
          child: Text( status,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: status == 'offline'? Colors.white : Colors.black )),
        )
      ],
    );
  }
  // -----------------------------------------------------
  BoxDecoration _buildDecoration() => BoxDecoration(
    color: status == 'online'
      ? Colors.green : Colors.red,
    borderRadius: BorderRadius.circular( 10 )
  );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~