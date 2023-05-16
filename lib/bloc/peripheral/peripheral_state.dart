part of 'peripheral_bloc.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@immutable
class PeripheralState {
  final List<Peripheral> items;
  final bool loading;
  final int  skip;
  final int  total;
  final String search;

  // -----------------------------------------------------
  const PeripheralState({ 
    this.items    = const [],  
    this.loading  = false,  
    this.skip     = 0,  
    this.total    = 0,
    this.search   = '', 
  } );
  
  // -----------------------------------------------------
  PeripheralState copyWith({
    List<Peripheral>? items, 
    int?    skip, 
    int?    total, 
    bool?   productState, 
    bool?   loading ,
    String? category,
    String? search,
  }) => PeripheralState( 
      items:    items    ?? this.items, 
      skip:     skip     ?? this.skip,
      total:    total    ?? this.total,
      loading:  loading  ?? this.loading,
      search:   search   ?? this.search );
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class PeripheralStateError extends PeripheralState {
  final String error;

  const PeripheralStateError( this.error );
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
