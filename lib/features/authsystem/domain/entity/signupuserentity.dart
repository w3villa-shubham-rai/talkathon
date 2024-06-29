class UserSignUpEntity{
   String? uUid;
   String? firstName;
   String? lastName;
   String? userEmail;
   String? password;
   String? country;
   String? imageUrl;
   String? phoneNumber;
  UserSignUpEntity({required this.firstName, required this.lastName,required this.userEmail,required this.password,required this.country,required this.imageUrl, required this.phoneNumber, required this.uUid});


  UserSignUpEntity.fromMap(Map<String,dynamic> map){
    firstName=map['firstName'];
    lastName=map['lastName'];
    userEmail=map['userEmail'];
    password=map['password'];
    country=map['country'];
    imageUrl=map['imageUrl'];
    phoneNumber=map['phoneNumber'];
    uUid=map['uUid'];
  }


  Map<String,dynamic> toJson(){
  return {
    "uUid":uUid,
    "firstName":firstName,
    "lastName":lastName,
    "userEmail":userEmail,
    "password":password,
    "country":country,
    "imageUrl":imageUrl,
    "phoneNumber":phoneNumber,
  };
}


}