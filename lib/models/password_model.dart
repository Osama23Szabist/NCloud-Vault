class Password {
  final String id;
  final String name;
  final String description;
  final String? password;
  final String? url;
  final String? username;

  Password({
    required this.id,
    required this.name,
    required this.description,
    this.password,
    this.url,
    this.username,
  });

  factory Password.fromJson(Map<String, dynamic> json) {
    return Password(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      password: json['password']?.toString(),
      url: json['url']?.toString(),
      username: json['username']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'password': password,
      'url': url,
      'username': username,
    };
  }
}
