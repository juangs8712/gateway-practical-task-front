part of 'menu_bloc.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MenuState {
  final bool isOpen;
  final String currentPage;
  late final AnimationController menuController;
  late final Animation<double> movement;
  late final Animation<double> opacity;
  // -----------------------------------------------------
  MenuState({ 
    required this.menuController,
    this.isOpen = false,
    this.currentPage = '',
    Animation<double>? movement,
    Animation<double>? opacity
  }){
    this.movement = movement ?? Tween<double>(begin: -200, end: 0)
      .animate( CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

    this.opacity = opacity ?? Tween<double>(begin: 0, end: 1)
      .animate(CurvedAnimation(parent: menuController, curve: Curves.easeInOut));
  }

  // -----------------------------------------------------
  MenuState copyWith(
  {
    bool? isOpen,
    String? currentPage,
    AnimationController? menuController,
    Animation<double>?   movement,
    Animation<double>?   opacity,
  }
  ) => MenuState(
      isOpen: isOpen ?? this.isOpen, 
      currentPage: currentPage ?? this.currentPage,
      menuController: menuController ?? this.menuController, 
      movement: movement ?? this.movement, 
      opacity: opacity ?? this.opacity    
    );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
