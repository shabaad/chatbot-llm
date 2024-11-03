class Validators {
  static String? validateRequired(String value, String type) {
    if (value.isEmpty) {
      return "$type ";
    }
    return null;
  }

  static String? validateMobile(String value) {
    //some of countries accept 9 digit so I change it range from 10-12 to 9-12
    // String patttern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    // RegExp regExp = RegExp(patttern);
    // if (value.isEmpty == true) {
    //   return 'Please enter phone number';
    // } else if (value.length > 16 ||
    //     value.length < 9 ||
    //     !regExp.hasMatch(value)) {
    //   return 'Please enter valid phone number';
    // }
    if (value.isEmpty == true) {
      return 'Please enter phone number';
    } else if (value.length != 10) {
      return 'Please enter valid phone number';
    }
    return null;
  }
 
}
