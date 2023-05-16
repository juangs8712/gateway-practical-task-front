part of 'gateway_bloc.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@immutable
class GatewayState {
  final List<Gateway> items;
  final bool loading;
  final int  skip;
  final int  total;
  final String search;

  // -----------------------------------------------------
  const GatewayState({ 
    this.items    = const [],  
    this.loading  = false,  
    this.skip     = 0,  
    this.total    = 0,
    this.search   = '', 
  } );
  
  // -----------------------------------------------------
  GatewayState copyWith({
    List<Gateway>? items, 
    int?    skip, 
    int?    total, 
    bool?   productState, 
    bool?   loading ,
    String? category,
    String? search,
  }) => GatewayState( 
      items:    items    ?? this.items, 
      skip:     skip     ?? this.skip,
      total:    total    ?? this.total,
      loading:  loading  ?? this.loading,
      search:   search   ?? this.search );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class GatewayStateError extends GatewayState {
  final String error;

  const GatewayStateError( this.error );
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
