import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

part 'menu_event.dart';
part 'menu_state.dart';
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc({ required AnimationController menuController }) 
  : super(MenuState( menuController: menuController )) {
    on<OpenMenuEvent>(_onOpenMenuEvent);
    on<CloseMenuEvent>(_onCloseMenuEvent);
    on<SetPageMenuEvent>(_onSetPageMenuEvent);
  }
  // -----------------------------------------------------
  _onCloseMenuEvent(CloseMenuEvent event, Emitter<MenuState> emit){
    emit(state.copyWith( isOpen: false ));
    state.menuController.reverse();
  }
  // -----------------------------------------------------
  _onOpenMenuEvent( OpenMenuEvent event, Emitter<MenuState> emit){
    emit(state.copyWith( isOpen: true ));
    state.menuController.forward();
  }
  // -----------------------------------------------------
  _onSetPageMenuEvent( SetPageMenuEvent event, Emitter<MenuState> emit){
    emit( state.copyWith( currentPage: event.currentPage ) );
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~