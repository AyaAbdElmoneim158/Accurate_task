class Status {
  final String name;

  Status({required this.name});

  // Empty constructor
  factory Status.empty() {
    return Status(name: '');
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
