abstract class ValidationServices {
  static String? validateOnlyCharacter(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This Field is required';
    }
    final regex = RegExp(r'^[a-zA-Z ]+$');
    if (!regex.hasMatch(value)) {
      return 'This field can only contain letters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!value.endsWith("@gmail.com")) {
      return 'Email must end with @gmail.com';
    }
    final regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*@gmail\.com$');
    if (!regex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]+$');
    if (!regex.hasMatch(value)) {
      return 'Password must contain uppercase, lowercase and number';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePaymentRate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    // Regex: number required, optional space, optional symbol/word
    final regex = RegExp(r'^\d+(\.\d+)?(\s*[a-zA-Z$€£₤₺₹¥₽₦₩]*)?$');

    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid payment rate (e.g. "100", "100\$", "100 USD", "100 EGP")';
    }

    return null;
  }

  static String? validateRequiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
