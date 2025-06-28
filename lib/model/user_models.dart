class UserDetailsModel {
  final String name;
  final String email;
  final String address;

  UserDetailsModel(
      {required this.name, required this.email, required this.address});

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
        name: json['name'], email: json['email'], address: json['address']);
  }

  Map<String, dynamic> toJson() =>
      {"name": name, "email": email, "address": address};
}
