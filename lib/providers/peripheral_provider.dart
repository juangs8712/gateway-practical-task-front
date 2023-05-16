import 'package:gateway/api/gateway_api.dart';
import 'package:gateway/models/peripheral_model.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class PeripheralProvider{
  static const rootPath = '/api/peripheral';
  // -----------------------------------------------------
  static Future<Map<String, dynamic>> getPeripherals({
    required  Map<String, String> queryParameters 
  }) async {
    final response = await GatewayApi.read( rootPath, queryParameters );
    final Map<String, dynamic> body = response['body'];

    if ( response['statusCode'] != 200 ) {
      throw GatewayApi.getErrorString( body ) ?? '';
    }
    final items = body['peripherals'].cast<Map<String, dynamic>>();
    final peripherals = items.map<Peripheral>((json)  => 
      Peripheral.fromJson( json )).toList();

    return {
      'total'       : body['total'],
      'peripherals' : peripherals
    };
  }
  // -----------------------------------------------------
  static Future<List<Peripheral>>  getPeripheralsByGateway( String id ) async {
    final response = await GatewayApi.read( '$rootPath/by-gateway/$id' );
    final Map<String, dynamic> body = response['body'];

    if ( response['statusCode'] != 200 ) {
      throw GatewayApi.getErrorString( body ) ?? '';
    }
    final items = body['peripherals'].cast<Map<String, dynamic>>();
    final List<Peripheral> peripherals = items.map<Peripheral>((json)  => 
      Peripheral.fromJson( json )).toList();

    return peripherals;
  }
  // -----------------------------------------------------
  static Future<Peripheral> post( Peripheral peripheral ) async {
    final response = await GatewayApi.post( rootPath, peripheral.toJson() );
    final resp = response['body'];

    if ( response['statusCode'] != 201 ) {
      throw GatewayApi.getErrorString( response['body'] ) ?? '';
    }
    return Peripheral.fromJson( resp['peripheral'] ); 
  }
  // -----------------------------------------------------
  static Future<Peripheral> put( Map<String, dynamic> json ) async {
    final response = await GatewayApi
      .put('$rootPath/${json['_id']}', json );
    
    if ( response['statusCode'] == 200 ) {
      return Peripheral.fromJson( response['body']['peripheral'] );
    }else{
      throw GatewayApi.getErrorString( response['body'] ) ?? '';
    }
  }
  // -----------------------------------------------------
  static Future<Peripheral> delete( String id ) async {
    final response = await GatewayApi.delete('$rootPath/$id' );
    
    if ( response['statusCode'] == 200 ) {
      return Peripheral.fromJson( response['body']['peripheral'] );
    }else{
      throw GatewayApi.getErrorString( response['body'] ) ?? '';
    }
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
