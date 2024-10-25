import 'status.dart';

class DefaultResponseCustomerRequest {
  final int id;
  final String date;
  final Status status;

  DefaultResponseCustomerRequest({
    required this.id,
    required this.date,
    required this.status,
  });

  factory DefaultResponseCustomerRequest.fromJson(Map<String, dynamic> json) {
    return DefaultResponseCustomerRequest(
      id: (json['id'] as int?) ?? 0,
      date: (json['date'] as String?) ?? '',
      status: json['status'] != null
          ? Status.fromJson(json['status'])
          : Status(name: ''),
    );
  }

  // Factory constructor for creating an empty instance
  factory DefaultResponseCustomerRequest.empty() {
    return DefaultResponseCustomerRequest(
      id: 0,
      date: '',
      status: Status(name: ''),
    );
  }
}
