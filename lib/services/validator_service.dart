class ValidatorService {
  static String? isRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    return null;
  }
}
