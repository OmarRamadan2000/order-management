class Order {
  final String id;
  final String clientName;
  final String address;
  String status;
  final Map<String, dynamic> details;
  Order copyWith({
    String? id,
    String? status,
    String? clientName,
    String? address,
    Map<String, dynamic>? details,
  }) {
    return Order(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      status: status ?? this.status,
      address: address ?? this.address,
      details: details ?? this.details,
    );
  }

  Order({
    required this.id,
    required this.clientName,
    required this.address,
    required this.status,
    required this.details,
  });
}
