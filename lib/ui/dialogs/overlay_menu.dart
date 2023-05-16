import 'package:flutter/material.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /// Tarjeta flotante desplazable por toda la pantalla.

class OverlayMenu{
  static OverlayEntry? _entry;
  static Offset  _offset  = const Offset( 50, 50 );

  // -----------------------------------------------------
  /// Función para mostrar la tarjeta.
  /// El parámetro [width] es el ancho de la tarjeta.
  /// 
  /// El parámetro [height] es el alto de la tarjeta.
  /// 
  /// El parámetro [globalMenuOffset] es un Offset que especifica
  /// el espacio que ocupan el menu principal y la barra de titulo.
  /// 
  /// El parámetro [items] es una lista de Strings con cada uno de 
  /// los valores a mostrar en el menú.
  /// 
  /// El parámetro [key] es un GlobalKey para obtener la
  /// posicion del componente que despliega el menu.
  /// 
  /// El parámetro [onTap] es la función a llamar
  /// cuando se da click sobre algún item en específico.
  static void showOverlay( BuildContext context,
    {
      required double height,
      // required double width,
      required List<String> items,
      required GlobalKey key,
      required void Function( String value ) onTap,
    }){
    if ( _entry != null ) {
      return;
    }

    // obtener la posicion del componente.
    // ( Aqui va incluido el espacio que ocupa
    // el menu principal y la barra de titulo )
    late Offset pos;
    final keyContext = key.currentContext;
    Size size = const Size( 200, 300 );
    if ( keyContext != null ) {
      final box = keyContext.findRenderObject() as RenderBox;
      pos = box.localToGlobal( Offset.zero );
      size = box.size;
    }
    
    // restar la posicion el desplazamiento provocado por el menu principal.
    final globalWidth = MediaQuery.of(context).size.width;
    _offset = Offset( 
      pos.dx - (globalWidth >= 700? 280 : 0),
      pos.dy - 120 );

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

              child: _OverlayedCard(
                width:  size.width,
                height: height,
                items:  items,
                onTap:  onTap,
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
    required this.items,
    required this.width,
    required this.height, 
    required this.onTap,
  }) : super(key: key);

  final List<String> items;
  final double width;
  final double height;
  final void Function( String value ) onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: _buildDecoration(),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: ( context, int index) { 
              return ListTile(
                title: Text( items[ index ] ),
                onTap: (){
                  OverlayMenu.hideOverlay();
                  onTap( items[ index ] );
                },
              );
            },)
        ),
      ],
    );
  }
  // -----------------------------------------------------
  /// Sombreado y redondeado de los bordes de la tarjeta.
  BoxDecoration _buildDecoration() => const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow( 
        color: Colors.grey, 
        offset: Offset( 0, 5 ),
        blurRadius: 20 )
    ]
  );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~