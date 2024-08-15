extension AppExtension on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
  String get errorMessage {
    switch (this) {
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      case 'email-already-in-use':
        return 'Email already in use';
      case 'invalid-email':
        return 'Invalid email';
      default:
        return 'Something went wrong';
    }
  }
}
