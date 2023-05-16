import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MyMenuItem extends StatefulWidget {
  const MyMenuItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  @override
  State<MyMenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MyMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: ( isHovered || widget.isActive )
        ? Colors.white.withOpacity(0.1)
        : Colors.transparent,

      child:  Material(
        color: Colors.transparent,
        // para hacer click y mostrar el efecto splash
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: MouseRegion(
              onEnter: (event) => setState(() => isHovered = true),
              onExit:  (event) => setState(() => isHovered = false),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon( widget.icon, color: Colors.white.withOpacity(0.3) ),
                  const SizedBox(width: 10),
                  Text(widget.text,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8)),
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~