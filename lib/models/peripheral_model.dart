import 'dart:convert';

import 'package:gateway/models/gateway_model.dart';

Peripheral peripheralFromJson(String str) => Peripheral.fromJson(json.decode(str));

String peripheralToJson(Peripheral data) => json.encode(data.toJson());
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Peripheral {
  final int?    uid;
  final String? id;
  final String  vendor;
  final Gateway gateway;
  final String  date;
  final String  status;
  final bool    state;
  // -----------------------------------------------------
  Peripheral({
    this.uid,
    this.id,
    required this.vendor,
    required this.gateway,
    required this.date,
    required this.status,
    required this.state,
  });
  // -----------------------------------------------------
  Peripheral copyWith({
    int?     uid,
    String?  id,
    String?  vendor,
    Gateway? gateway,
    String?  date,
    String?  status,
    bool?    state,
  }) => 
    Peripheral(
      uid:     uid     ?? this.uid,
      id:      id      ?? this.id,
      vendor:  vendor  ?? this.vendor,
      gateway: gateway ?? this.gateway,
      date:    date    ?? this.date,
      status:  status  ?? this.status,
      state:   state   ?? this.state,
    );
  // -----------------------------------------------------
  factory Peripheral.fromJson(Map<String, dynamic> json) => Peripheral(
    uid:     json["uid"],
    id:      json["_id"],
    vendor:  json["vendor"],
    gateway: Gateway.fromJson(json["gateway"]),
    date:    json["date"] ?? DateTime.now().toLocal().toString(),
    status:  json["status"],
    state:   json["state"] ?? true,
  );
  // -----------------------------------------------------
  Map<String, dynamic> toJson() => {
    "vendor":  vendor,
    "gateway": gateway.id,
    "date":    date,
    "status":  status,
    "state":   state,
  };
  // -----------------------------------------------------
  @override
  String toString() => 
    '\n( '
    'uid:     $uid, '
    'vendor:  $vendor, '
    'gateway: $gateway, '
    'date:    $date, '
    'status:  $status, '
    'state:   $state )';
   // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~