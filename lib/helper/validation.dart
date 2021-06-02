class Validation {
  static String? emailValidation(String? val) {
    if (val != null && !val.contains("@")) {
      return "Please Enter a valid email";
    }
    return null;
  }

  static String? passwordValidation(String? val) {
    if (val != null && val.length < 5) {
      return "Password shoud be more at least 5 char";
    }
    return null;
  }
}
