import 'status.dart';

class ResponseCustomerRequestFetching {
  final int id;
  final Status status;
  final String date;
  final DeliveryTypeModel deliveryType;
  final String notes;
  final String payeeName;
  final RequestType type;
  final bool editable;
  final bool deletable;

  ResponseCustomerRequestFetching({
    required this.id,
    required this.status,
    required this.date,
    required this.deliveryType,
    this.notes = '',
    this.payeeName = '',
    required this.type,
    required this.editable,
    required this.deletable,
  });

  // Empty constructor
  factory ResponseCustomerRequestFetching.empty() {
    return ResponseCustomerRequestFetching(
      id: 0,
      status: Status.empty(), // Assuming Status has an empty method
      date: '',
      deliveryType: DeliveryTypeModel.empty(),
      notes: '',
      payeeName: '',
      type: RequestType.empty(),
      editable: false,
      deletable: false,
    );
  }

  factory ResponseCustomerRequestFetching.fromJson(Map<String, dynamic> json) {
    return ResponseCustomerRequestFetching(
      id: (json['id'] as int?) ?? 0,
      status: Status.fromJson(json['status']),
      date: (json['date'] as String?) ?? '',
      deliveryType: DeliveryTypeModel.fromJson(json['deliveryType']),
      notes: (json['notes'] as String?) ?? '',
      payeeName: (json['payeeName'] as String?) ?? '',
      type: RequestType.fromJson(json['type']),
      editable: (json['editable'] as bool?) ?? false,
      deletable: (json['deletable'] as bool?) ?? false,
    );
  }
}

class DeliveryTypeModel {
  final String code;

  final String name;

  DeliveryTypeModel({required this.name, required this.code});

  // Empty constructor
  factory DeliveryTypeModel.empty() {
    return DeliveryTypeModel(code: '', name: '');
  }

  factory DeliveryTypeModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTypeModel(
      name: (json['name'] as String?) ?? '',
      code: (json['code'] as String?) ?? '',
    );
  }
}

class RequestType {
  final String code;
  final String name;

  RequestType({required this.code, required this.name});

  // Empty constructor
  factory RequestType.empty() {
    return RequestType(code: '', name: '');
  }

  factory RequestType.fromJson(Map<String, dynamic> json) {
    return RequestType(
      code: (json['code'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
    );
  }
}
