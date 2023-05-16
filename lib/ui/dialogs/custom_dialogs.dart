import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:gateway/services/navigation_service.dart';


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /// Implementa diálogos básicos como SimpleDialog, AlertDialog y ShowSnackBar.
class CustomDialogs{

// -----------------------------------------------------
  /// Muestra un dialogo de tipo AlertDialog.
  static Future<void> dialogBuilder({
    required Widget content,
    Widget? title,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    final context = NavigationService.navigatorKey.currentContext!;
    
    return Future.delayed( 
      Duration.zero, 
      ()=> showDialog<void>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return AlertDialog( 
            title: title,
            content: content,
            actions: actions,
            titleTextStyle: GoogleFonts.poppins( 
                color: Colors.black, 
                fontSize: 16,
                fontWeight: FontWeight.bold ),
            contentTextStyle: GoogleFonts.poppins( 
                color: Colors.black, 
                fontSize: 14 ),
          );
        },
      )
    );
  }
  // -----------------------------------------------------
    /// Lanza un cuadro de dialogo que muestra un
    /// listado de opciones a seleccionar.
  static Future<String?> simpleDialogBuilder({ 
    required Map<String, String> optionList ,
    Widget? title,
  })async {
    
    final context = NavigationService.navigatorKey.currentContext!;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {

        return SimpleDialog(
          title: title,
          children: optionList.keys.map(( key ) 
            => SimpleDialogOption(
              onPressed: () => Navigator.pop( context, optionList[ key ]),
              child: Text( key, style: GoogleFonts.poppins(
                color: Colors.black )))
          ).toList(),
        );
      }
    );
  }

  // -----------------------------------------------------
  static Future<void> customSnackbar( {
    required Widget content,
    SnackBarAction? action
  } ) async{

    final context = NavigationService.navigatorKey.currentContext!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content, 
      duration: const Duration(milliseconds: 4000 ),
      action: action ));
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~