class SignInUsername {
  final String value;

  SignInUsername(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInUsername &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
