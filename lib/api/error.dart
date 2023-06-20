class Error implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  Error([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class LocalSourceNotAvailable extends Error {
  LocalSourceNotAvailable([String? message])
      : super(message, "LocalDataSource Error: ");

  get message => _message;
}

class ApiError implements Error {
  @override
  final dynamic _message;
  @override
  final dynamic _prefix;

  ApiError([this._message, this._prefix]);
}

class RemoteSourceNotAvailable extends ApiError {
  RemoteSourceNotAvailable([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ApiError {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ApiError {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}
class ServerException extends ApiError {
  ServerException([message]) : super(message, "Server Error: ");
}

class InvalidInputException extends ApiError {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}