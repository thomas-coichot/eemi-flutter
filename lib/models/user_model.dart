class UserModel {
  final String id;
  final String lastname;
  final String firstname;
  final String email;
  final List roles;

  const UserModel({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.email,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      email: json['email'],
      roles: json['roles'],
    );
  }

  String getFullName() {
    return '$firstname $lastname';
  }
}
