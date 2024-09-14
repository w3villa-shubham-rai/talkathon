class User {
  final String uUid;
  final String country;
  final String firstName;
  final String imageUrl;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String userEmail;
  final bool isOnline;
  final String lastOnline;

  User({
    required this.uUid,
    required this.country,
    required this.firstName,
    required this.imageUrl,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.userEmail,
    this.isOnline=false,
    this.lastOnline='',
  });
}
