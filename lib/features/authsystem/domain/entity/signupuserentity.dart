class UserSignUpEntity {
  String? uUid;
  String? firstName;
  String? lastName;
  String? userEmail;
  String? password;
  String? country;
  String? imageUrl;
  String? phoneNumber;


  UserSignUpEntity({
    required this.uUid,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
    required this.password,
    required this.country,
    required this.imageUrl,
    required this.phoneNumber,
  });

  UserSignUpEntity.fromMap(Map<String, dynamic> map) {
    uUid = map['uUid'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    userEmail = map['userEmail'];
    password = map['password'];
    country = map['country'];
    imageUrl = map['imageUrl'];
    phoneNumber = map['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uUid': uUid,
      'firstName': firstName,
      'lastName': lastName,
      'userEmail': userEmail,
      'password': password,
      'country': country,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
    };
  }

  UserSignUpEntity copyWith({
    String? uUid,
    String? firstName,
    String? lastName,
    String? userEmail,
    String? password,
    String? country,
    String? imageUrl,
    String? phoneNumber,
  }) {
    return UserSignUpEntity(
      uUid: uUid ?? this.uUid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userEmail: userEmail ?? this.userEmail,
      password: password ?? this.password,
      country: country ?? this.country,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
