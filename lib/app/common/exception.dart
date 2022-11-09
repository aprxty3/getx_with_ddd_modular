class GenericException implements Exception {
  final ExceptionCode code;
  final dynamic info;

  GenericException({this.code = ExceptionCode.unknown, this.info});

  @override
  String toString() {
    return '$runtimeType: ${code.value}';
  }

  String get message {
    switch (runtimeType) {
      case NotFoundException:
        return '${code.value}: $info\nis not found.';
      case NotUniqueException:
        return '${code.value}: $info\nalready exists.';
      case NullEmptyException:
        return '${code.value}\nmust not be null or empty.';
      case LengthException:
        return '${code.value} must be $info letters or shorter.';
      case FalseException:
        return '${code.value} $info must be true.';
      case RemovalException:
        return code == ExceptionCode.category
            ? 'Cannot be removed;\nthis category contains notes.'
            : 'Cannot be removed';
      default:
        return 'Unknown error occurred.';
    }
  }
}

class NotFoundException extends GenericException {
  NotFoundException({required ExceptionCode code, required String target})
      : assert(target.isNotEmpty),
        super(code: code, info: target);
}

class NotUniqueException extends GenericException {
  NotUniqueException({required ExceptionCode code, required String value})
      : assert(value.isNotEmpty),
        super(code: code, info: value);
}

class NullEmptyException extends GenericException {
  NullEmptyException({required ExceptionCode code}) : super(code: code);
}

class LengthException extends GenericException {
  LengthException({required ExceptionCode code, required int max})
      : assert(max > 0),
        super(code: code, info: max);
}

class RemovalException extends GenericException {
  RemovalException({required ExceptionCode code}) : super(code: code);
}

class FalseException extends GenericException {
  FalseException({required ExceptionCode code, required bool value})
      : assert(value == false),
        super(code: code, info: value);
}

class ServerRequestException extends GenericException {
  ServerRequestException({required ExceptionCode code, required String value})
      : super(
            code: code,
            info: value.isEmpty
                ? 'Sorry server is busy, Please try again later'
                : value);
}

class InvalidAuthInputException extends GenericException {
  InvalidAuthInputException(
      {required ExceptionCode code, required String value})
      : super(
            code: code,
            info: value.isEmpty ? 'Invalid Username or Password' : value);
}

enum ExceptionCode {
  unknown,
  category,
  categoryId,
  categoryName,
  note,
  noteId,
  noteTitle,
  rule,
  signInEmail,
  signInPassword,
  signInTerms,
  serverFailure,
  date,
}

extension ExceptionCodeValue on ExceptionCode {
  String get value {
    switch (this) {
      case ExceptionCode.category:
        return 'Category';
      case ExceptionCode.categoryId:
        return 'Category ID';
      case ExceptionCode.categoryName:
        return 'Category name';
      case ExceptionCode.note:
        return 'Note';
      case ExceptionCode.noteId:
        return 'Note ID';
      case ExceptionCode.noteTitle:
        return 'Note title';
      case ExceptionCode.rule:
        return "Rule not Available";
      case ExceptionCode.date:
        return "Date not Available";
      case ExceptionCode.signInEmail:
        return 'SignIn email';
      case ExceptionCode.signInPassword:
        return 'SignIn password';
      case ExceptionCode.signInTerms:
        return 'SignIn terms';
      case ExceptionCode.serverFailure:
        return 'Server Error';
      default:
        return 'Unknown';
    }
  }
}
