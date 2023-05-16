import 'package:flutter/material.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /// Tarjeta flotante desplazable por toda la pantalla.

class OverlayCard{
  static OverlayEntry? _entry;
  static Offset  _offset  = const Offset( 50, 50 );


  // -----------------------------------------------------
  /// Función para mostrar la tarjeta.
  /// El parámetro [width] es el ancho de la tarjeta.
  /// 
  /// El parámetro [height] es el alto de la tarjeta.
  /// 
  /// El parámetro [startPos] es un Offset opcional con la posición
  /// inicial (topLeft) done se dibuja la tarjeta por primera vez.
  /// En caso de que sea null, la tarjeta se inicializa en la posición
  /// Offset( 50, 50 ). 
  /// 
  /// El parámetro [child] es un widget con el contenido de la tarjeta.
  static void showOverlay( BuildContext context,
    {
      required double height,
      required double width,
      required Widget child,
      Offset? startPos,
    }){
    if ( _entry != null ) {
      return;
    }

    _offset = startPos ?? _offset;
    _entry = OverlayEntry(
      builder: ( BuildContext context ) 
        => Positioned(
          left: _offset.dx,
          top:  _offset.dy,
          child: Material(
            child: GestureDetector(
              onPanUpdate: ( details ){
                  _offset += details.delta;
                  _entry!.markNeedsBuild();
              },

              // mostrar la tarjeta.
              child: _OverlayedCard(
                width:   width,
                height:  height,
                onClose: hideOverlay,
                child:   child,
              ),
            ),
          ),
        ) );

    final overlay = Overlay.of(context);

    overlay.insert(_entry!);
  }
  // -----------------------------------------------------
  /// Función para cerrar la tarjeta cuando se presiona el botón de cerrar.
  static void hideOverlay(){
    if ( _entry != null ) {
      _entry!.remove();
      _entry = null;
    }
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class _OverlayedCard extends StatelessWidget {
  /// Marco de la tarjeta mostrada por el overlay.
  /// 
  /// Para la descripción de los parámetros ver el widget principal.
  const _OverlayedCard({
    Key? key,
    required this.child,
    required this.width,
    required this.height, 
    this.onClose,
  }) : super(key: key);

  final Widget child;
  final double width;
  final double height;
  final void Function()? onClose;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: _buildDecoration(),
      child: Stack(
        children: [
          child,
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: onClose,
              splashRadius: 10,
              icon: const Icon( Icons.close, size: 20, )))
        ],
      )
    );
  }
  // -----------------------------------------------------
  /// Sombreado y redondeado de los bordes de la tarjeta.
  BoxDecoration _buildDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular( 15 ),
    boxShadow: const [
      BoxShadow( 
        color: Colors.grey, 
        offset: Offset( 0, 5 ),
        blurRadius: 20 )
    ]
  );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~