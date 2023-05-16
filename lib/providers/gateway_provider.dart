import 'package:gateway/api/gateway_api.dart';
import 'package:gateway/models/gateway_model.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class GatewayProvider{
  static const rootPath = '/api/gateway';
  // -----------------------------------------------------
  static Future<Map<String, dynamic>> getGateways({
    required  Map<String, String> queryParameters 
  }) async {
    final response = await GatewayApi.read( rootPath, queryParameters );
    final Map<String, dynamic> body = response['body'];

    if ( response['statusCode'] != 200 ) {
      throw GatewayApi.getErrorString( body ) ?? '';
    }
    final items = body['gateways'].cast<Map<String, dynamic>>();
    final gateways = items.map<Gateway>((json) => 
      Gateway.fromJson( json )).toList();

    return {
      'total'    : body['total'],
      'gateways' : gateways
    };
  }
  // -----------------------------------------------------
  static Future<Gateway> post( Gateway gateway ) async {
    final response = await GatewayApi.post( rootPath, gateway.toJson() );
    final resp = response['body'];

    if ( response['statusCode'] != 201 ) {
      throw GatewayApi.getErrorString( response['body'] ) ?? '';
    }
    return Gateway.fromJson( resp['gateway'] ); 
  }
  // -----------------------------------------------------
  static Future<Gateway> put( Gateway gateway ) async {
    final response = await GatewayApi
      .put('$rootPath/${gateway.id}', gateway.toJson() );
    
    if ( response['statusCode'] == 200 ) {
      return Gateway.fromJson( response['body']['gateway'] );
    }else{
      throw GatewayApi.getErrorString( response['body'] ) ?? '';
    }
  }
  // -----------------------------------------------------
  static Future<Gateway> delete( String id ) async {
    final response = await GatewayApi.delete('$rootPath/$id' );
    
    if ( response['statusCode'] == 200 ) {
      return Gateway.fromJson( response['body']['gateway'] );
    }else{
      throw GatewayApi.getErrorString( response['body'] ) ?? '';
    }
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
