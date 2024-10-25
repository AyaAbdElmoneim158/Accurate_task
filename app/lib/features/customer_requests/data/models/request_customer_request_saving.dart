class RequestCustomerRequestSaving {
  int? id; // New field for the ID
  String? date;
  String? typeCode;
  String? payeeName;
  String? notes;
  String? deliveryTypeCode;

  RequestCustomerRequestSaving({
    this.id, // Include id in the constructor
    this.date,
    this.typeCode,
    this.payeeName,
    this.notes,
    this.deliveryTypeCode,
  });

  // Convert JSON to RequestCustomerRequestSaving instance
  factory RequestCustomerRequestSaving.fromJson(Map<String, dynamic> json) {
    return RequestCustomerRequestSaving(
      id: json['id'] as int?, // Read id from JSON
      date: json['date'] as String?,
      typeCode: json['typeCode'] as String?,
      payeeName: json['payeeName'] as String?,
      notes: json['notes'] as String?,
      deliveryTypeCode: json['deliveryTypeCode'] as String?,
    );
  }

  // Convert RequestCustomerRequestSaving instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date ?? '',
      'typeCode': typeCode ?? '',
      'payeeName': payeeName ?? '',
      'notes': notes ?? '',
      'deliveryTypeCode': deliveryTypeCode ?? '',
    };
  }

  Map<String, dynamic> toJsonEditing() {
    return {
      'id': id ?? 0,
      'date': date ?? '',
      'typeCode': typeCode ?? '',
      'payeeName': payeeName ?? '',
      'notes': notes ?? '',
      'deliveryTypeCode': deliveryTypeCode ?? '',
    };
  }
}
