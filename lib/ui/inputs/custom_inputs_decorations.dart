import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /// Estilos para entrada de texto.
  /// 
  /// Clase donde se definen varios métodos para la configuración
  /// de estilos en los cuadros de edición.
class CustomInputDecorations {
  // -----------------------------------------------------
  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder( borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: Colors.grey,
      ),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  // -----------------------------------------------------
  /// Estilo para entrada de texto.
  /// 
  /// Estilo para los cuadros de búsquedas.
  static InputDecoration searchInputDecoration(
    {required String hint, required IconData icon}) {

    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric( horizontal: 10, vertical: 8),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey,) ,
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey)

    );
  }
  // -----------------------------------------------------
  /// Estilo para entrada de texto.
  /// 
  /// Estilo para la entrada de textos con bordes cuadrados en negro.
  static InputDecoration rectInputDecoration(
    { required String hint, String? label, String? helperText, Widget? prefix, Widget? suffix }) {

    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric( horizontal: 10, vertical: 8),
      border: const OutlineInputBorder( borderSide: BorderSide(color: Colors.grey)),
      hintText:    hint,
      label:       label != null ? Text( label ) : null,
      prefixIcon:  prefix,
      suffixIcon:  suffix,
      helperText:  helperText,
      labelStyle:  GoogleFonts.poppins( color: Colors.black54 ),
      hintStyle:   GoogleFonts.poppins( color: Colors.black45 ),
      helperStyle: GoogleFonts.poppins( color: Colors.grey, fontSize: 11 ),
    );
  }
  // -----------------------------------------------------
  /// Estilo para entrada de texto.
  /// 
  /// Estilo para la entrada de textos sin bordes exteriores.
  static InputDecoration registerInputDecoration(
    { required String hint, String? labelText, String? helperText, Widget? prefix, Widget? suffix }) {

    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric( horizontal: 10, vertical: 0 ),
      hintText:    hint,
      labelText:   labelText,
      helperText:  helperText,
      prefixIcon:  prefix,
      suffixIcon:  suffix,
      labelStyle:  GoogleFonts.poppins( color: Colors.grey, fontSize: 14 ),
      hintStyle:   GoogleFonts.poppins( color: Colors.grey, fontSize: 13 ),
      helperStyle: GoogleFonts.poppins( color: Colors.grey, fontSize: 13 ),
      errorStyle:  GoogleFonts.poppins( color: Colors.red,  fontSize: 13 ),
    );
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
