import 'package:flutter/material.dart';

import '../../inputs/custom_inputs_decorations.dart';


// --------------------------------------------------------------------------
class SearchText extends StatelessWidget {
  const SearchText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecoration(),
      child: Overlay(
        initialEntries: [
          OverlayEntry(builder: (BuildContext context) { 
            return TextField(
              decoration: CustomInputDecorations.searchInputDecoration(hint: 'Buscar', icon: Icons.search_outlined),
            );
           })
        ],
      )
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.withOpacity(0.1)
    );
  }
}
// --------------------------------------------------------------------------