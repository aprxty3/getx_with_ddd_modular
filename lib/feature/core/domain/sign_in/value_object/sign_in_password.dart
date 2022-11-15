class SignInPassword {
  final String value;

  const SignInPassword(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInPassword &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
