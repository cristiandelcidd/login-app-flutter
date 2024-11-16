class User {
  final String id;
  final String email;
  final String password;
  final String phone;
  final String name;
  final String profile;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.profile,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
      name: map['name'] as String,
      profile: map['profile'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'profile': profile,
    };
  }
}
