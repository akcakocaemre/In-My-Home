/**
 * Validator class for validating the following
 * User Credentials
 *    email : must be in common email characters
 *    password : must be unempty and longer than 6 characters
 *    name : must be unempty
 */


class Validator{
  /**
   * Validates the name
   * @param : name <String>
   *  @return : String
   */
  static String? validateName({required String? name}){
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }
  /**
   * Validates the email
   * @param : email <String>
   *  @return : String
   */
  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }
  /**
   * Validates the password
   * @param : password <String>
   *  @return : String
   */
  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }
}