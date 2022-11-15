class RequestResetPassEmail {
  final String value;

  RequestResetPassEmail(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RequestResetPassEmail && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
