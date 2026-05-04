/// Base class for custom application exceptions.
class AppException implements Exception {
  final dynamic _message; // Message associated with the exception
  final dynamic _prefix; // Prefix for the exception

  /// Constructor for creating an [AppException] instance.
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_message$_prefix'; // Returns the formatted error message
  }
}

/// Thrown when the server is unreachable or the request times out
class FetchDataException extends AppException {
  FetchDataException([String? message])
    : super(message, 'Error During Communication');
}

/// Thrown for 400 status codes indicating an incorrect API call
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

/// Thrown for 401 or 403 status codes when credentials or API keys are invalid
class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
    : super(message, 'Unauthorised request');
}

/// Thrown when form validation or user input fails processing
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

/// Specifically handles SocketExceptions when no data connection is active
class NoInternetException extends AppException {
  NoInternetException([String? message])
    : super(message, 'No Internet Connection');
}
