class Shipment {
  final String reference;
  final String from;
  final String status;
  final String createdAt;
  final String deliverAt;
  final String location;
  final String price;

  Shipment(
      {this.reference,
      this.from,
      this.status,
      this.createdAt,
      this.deliverAt,
      this.location,
      this.price});

  Shipment.fromJson(Map<String, dynamic> json)
      : reference = json['reference'],
        from = json['from'] as String,
        status = json['status'] as String,
        createdAt = json['created_at'] as String,
        deliverAt = json['deliver_at'] as String,
        location = json['location'] as String,
        price = json['price'] as String;
}
