class Validation{

  String? validateDomainID(String? domainId) {
    if (domainId == null || domainId.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;



  }
  String? validateDate(String? date){
    if (date == null || date.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;

  }

  String? validateDeviceId(String? deviceId){
    if(deviceId == null || deviceId.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;

  }

  String? validateEmail(String? email) {
    if ( email == null || email.isEmpty) {
      return 'This field cannot be empty';
    }

    if (!email.startsWith(RegExp(r'[A-za-z]'))) {
      return "Email cannot start with special characters";
    }

    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return "Invalid Email";
    }
    return null;


  }

  String? validateSubscriber(String? subscriber) {
    if (subscriber == null || subscriber.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;



  }

  String? validatePhoneNo(String?  phoneno){
    if ( phoneno == null||phoneno.isEmpty) {
      return "This field can't be empty";
    } else if ( phoneno.length > 10 &&  phoneno.contains(RegExp(r'[0-9]'))) {
      return (" phoneno number can't be more than 10 digits");
    } else if ( phoneno.length < 10 &&  phoneno.contains(RegExp(r'[0-9]'))) {
      return (" phoneno number can't be less than 10 digits");
    } else if ( phoneno.contains(RegExp(r'[A-Z]')) ||
        phoneno.contains(RegExp(r'[a-z]')) &&
            phoneno.contains(RegExp(r'[0-9]'))) {
      return (" phoneno number can only contain numbers");
    } else if (!RegExp(r"[0-9]{10}").hasMatch( phoneno)) {
      return ("Not a valid  phoneno number");
    } else if (! phoneno.startsWith(RegExp(r"[0-9]"))) {
      return ("Not a valid  phoneno number");
    }
    return null;
  }
}