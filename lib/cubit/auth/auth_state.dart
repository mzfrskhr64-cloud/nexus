class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.errorMessage,
  });

}