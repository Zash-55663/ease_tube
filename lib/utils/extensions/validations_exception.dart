// Extension on the String class to provide custom email validation logic
extension EmailValidatorExtension on String {
  // Validates if a string follows a standard email format using Regular Expressions
  bool emailValidator() {
    // Regex pattern:
    // ^.+ : Matches any character at the start
    // @[a-zA-Z]+ : Ensures an '@' symbol followed by domain characters
    // \.{1}[a-zA-Z]+ : Ensures exactly one dot followed by a top-level domain (e.g., .com)
    // (\.{0,1}[a-zA-Z]+)$ : Optional support for secondary domains (e.g., .co.uk)
    bool emailValid = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(this);

    return emailValid;
  }
}
