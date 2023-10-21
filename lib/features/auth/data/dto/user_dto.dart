class UserDTO {
  String? email;
  int? occupationLevel;
  String? occupationName;

  UserDTO({
    this.email,
    this.occupationLevel,
    this.occupationName,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
      email: json.containsKey('email') ? json['email'] : null,
      occupationLevel: json.containsKey('occupation_level')
          ? json['occupation_level']
          : null,
      occupationName:
          json.containsKey('occupation_name') ? json['occupation_name'] : null);

  Map<String, dynamic> toJson() => {
        'email': email,
        'occupation_level': occupationLevel,
        'occupation_name': occupationName
      };
}
