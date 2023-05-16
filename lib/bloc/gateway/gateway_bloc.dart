import 'package:bloc/bloc.dart';
import 'package:gateway/models/gateway_model.dart';
import 'package:gateway/providers/gateway_provider.dart';
import 'package:meta/meta.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
part 'gateway_event.dart';
part 'gateway_state.dart';

class GatewayBloc extends Bloc<GatewayEvent, GatewayState> {
  GatewayBloc() : super( const GatewayState( items: [], skip: 0, total: 0, loading: true )) 
  {
    on<GatewayErrorEvent>      ( _onGatewayEventError );
    on<GatewayClearErrorEvent> ( _onGatewayClearErrorEvent );
    on<GatewayGetListEvent>    ( _onGatewayGetListEvent );
    on<GatewayForwardEvent>    ( _onGatewayForwardEvent );
    on<GatewayBackwardEvent>   ( _onGatewayBackwardEvent );

    add( GatewayGetListEvent() );
  }
  // -----------------------------------------------------
    _onGatewayEventError( GatewayErrorEvent event, Emitter<GatewayState> emit){
      emit(GatewayStateError( event.error ));
    }
  // -----------------------------------------------------
  _onGatewayClearErrorEvent( GatewayClearErrorEvent event, Emitter<GatewayState> emit ){
    emit( const GatewayState() );
  }
  // -----------------------------------------------------
  _onGatewayGetListEvent( GatewayGetListEvent event, Emitter<GatewayState> emit ) async {
    try {
      // Set loading to true
      emit( state.copyWith( loading: true ) );
      final queryParameters = { 
        'skip' : state.skip.toString(),
        'limit': '10'
      };
      // Get the list of Gateways
      final response = await GatewayProvider.getGateways(
        queryParameters: queryParameters );

      emit( state.copyWith( 
        items: response['gateways'], 
        total: response['total'],
        loading: false ));
    } catch (e) {
      emit( GatewayStateError( e.toString() ));
    }
  }
  // -----------------------------------------------------
  _onGatewayForwardEvent( GatewayForwardEvent event, Emitter<GatewayState> emit ){
    final int skip = state.skip + 10;
    if ( skip > state.total ) return;

    emit( state.copyWith( skip: skip ));
    add( GatewayGetListEvent() );
  }
  // -----------------------------------------------------
  _onGatewayBackwardEvent( GatewayBackwardEvent event, Emitter<GatewayState> emit ){
    final int skip = state.skip - 10;

    emit( state.copyWith( skip: skip < 0 ? 0 : skip ));
    add( GatewayGetListEvent() );
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
