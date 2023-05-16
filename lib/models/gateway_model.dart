
import 'dart:convert';

Gateway shoppingProductFromJson(String str) => Gateway.fromJson(json.decode(str));

String shoppingProductToJson(Gateway data) => json.encode(data.toJson());

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Gateway {
  final String? id;
  final String name;
  final String ipv4;
  final bool state;
  // -----------------------------------------------------
  Gateway({
    this.id,
    required this.name,
    required this.ipv4,
    required this.state,
  });
  // -----------------------------------------------------
  Gateway copyWith({
    String? id,
    String? name,
    String? ipv4,
    bool?   state,
  }) => 
    Gateway(
      id:    id    ?? this.id,
      name:  name  ?? this.name,
      ipv4:  ipv4  ?? this.ipv4,
      state: state ?? this.state,
    );
  // -----------------------------------------------------
  factory Gateway.fromJson(Map<String, dynamic> json) => Gateway(
    id:    json["_id"],
    name:  json["name"],
    ipv4:  json["ipv4"]  ?? '',
    state: json["state"] ?? true,
  );
  // -----------------------------------------------------
  Map<String, dynamic> toJson() => {
    "name":  name,
    "ipv4":  ipv4,
    "state": state,
  };
  // -----------------------------------------------------
  @override
  String toString()=> '\n( id: $id, name: $name, ipv4: $ipv4, state: $state )';
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
