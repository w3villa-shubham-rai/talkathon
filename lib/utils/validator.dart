class ValidatorOfForm {
  //++++++ Validate function of email +++++++++

  String? emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

// ++++++++++++++++validate function of Passsword+++++++++++

  
  String? passwordValidate(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters long';
    }
    return null;
  }


  String? nameValidate(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? tittleAndDescriptionValidate(String value){
    if(value.isEmpty){
      return 'Please enter any Text';
    }
    return null;
  }

}