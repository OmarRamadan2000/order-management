import '../../domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.id,
    required super.clientName,
    required super.address,
    required super.status,
    required super.details,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      clientName: json['clientName'],
      address: json['address'],
      status: json['status'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'address': address,
      'status': status,
      'details': details,
    };
  }
}
