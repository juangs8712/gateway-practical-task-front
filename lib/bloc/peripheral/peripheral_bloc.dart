import 'package:bloc/bloc.dart';

import 'package:gateway/models/peripheral_model.dart';
import 'package:gateway/providers/peripheral_provider.dart';
import 'package:meta/meta.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
part 'peripheral_event.dart';
part 'peripheral_state.dart';

class PeripheralBloc extends Bloc<PeripheralEvent, PeripheralState> {
  PeripheralBloc() : super( const PeripheralState( items: [], skip: 0, total: 0, loading: true )) 
  {
    on<PeripheralErrorEvent>      ( _onPeripheralEventError );
    on<PeripheralClearErrorEvent> ( _onPeripheralClearErrorEvent );
    on<PeripheralGetListEvent>    ( _onPeripheralGetListEvent );
    on<PeripheralForwardEvent>    ( _onPeripheralForwardEvent );
    on<PeripheralBackwardEvent>   ( _onPeripheralBackwardEvent );

    add( PeripheralGetListEvent() );
  }
  // -----------------------------------------------------
    _onPeripheralEventError( PeripheralErrorEvent event, Emitter<PeripheralState> emit){
      emit(PeripheralStateError( event.error ));
    }
  // -----------------------------------------------------
  _onPeripheralClearErrorEvent( PeripheralClearErrorEvent event, Emitter<PeripheralState> emit ){
    emit( const PeripheralState() );
  }
  // -----------------------------------------------------
  _onPeripheralGetListEvent( PeripheralGetListEvent event, Emitter<PeripheralState> emit ) async {
    try {
      // Set loading to true
      emit( state.copyWith( loading: true ) );
      final queryParameters = { 
        'skip' : state.skip.toString(),
        'limit': '10'
      };
      // Get the list of Peripherals
      final response = await PeripheralProvider.getPeripherals(
        queryParameters: queryParameters );

      emit( state.copyWith( 
        items: response['peripherals'], 
        total: response['total'],
        loading: false ));
    } catch (e) {
      emit( PeripheralStateError( e.toString() ));
    }
  }
  // -----------------------------------------------------
  _onPeripheralForwardEvent( PeripheralForwardEvent event, Emitter<PeripheralState> emit ){
    final int skip = state.skip + 10;
    if ( skip > state.total ) return;

    emit( state.copyWith( skip: skip ));
    add( PeripheralGetListEvent() );
  }
  // -----------------------------------------------------
  _onPeripheralBackwardEvent( PeripheralBackwardEvent event, Emitter<PeripheralState> emit ){
    final int skip = state.skip - 10;

    emit( state.copyWith( skip: skip < 0 ? 0 : skip ));
    add( PeripheralGetListEvent() );
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
