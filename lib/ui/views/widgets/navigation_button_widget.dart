import 'package:flutter/material.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class NavigationButtonsWidget extends StatelessWidget {
  const NavigationButtonsWidget({
    super.key, 
    required this.skip, 
    required this.total, 
    this.onTapBackward, 
    this.onTapFordward
  });

  final int skip;
  final int total;
  final void Function()? onTapBackward;
  final void Function()? onTapFordward;
  @override
  Widget build(BuildContext context) {
    final int lastIndex = skip + 10 < total 
      ? skip + 10 : total;

    return Container(
      margin: const EdgeInsets.symmetric( vertical: 5),
      height: 40,
      decoration: _buildDecoration(),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Prior button
          IconButton(
            splashRadius: 22,
            onPressed: skip == 0 
              ? null 
              : onTapBackward, 
            icon: const Icon( Icons.chevron_left )),

          Text( '${skip + 1}-$lastIndex / $total' ),

          // Next button
          IconButton(
            splashRadius: 22,
            onPressed: ( lastIndex >= total )
              ? null 
              : onTapFordward, 
            icon: const Icon( Icons.chevron_right_outlined )),
        ],
      ),
    );
  }

  // -----------------------------------------------------
  BoxDecoration _buildDecoration() => BoxDecoration(
    color: const Color(0xFFDEE2E8).withOpacity( 0.80 ),
    borderRadius: BorderRadius.circular( 10 )
  );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~