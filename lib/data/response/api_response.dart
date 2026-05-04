import 'package:ease_tube/data/response/status.dart';

// A generic wrapper that encapsulates data, status, and potential error messages
class ApiResponse<T> {
  final Status status;
  final T? data;
  final String? message;

  // Private constructor to enforce the use of named factory-style constructors
  const ApiResponse._({required this.status, this.data, this.message});

  // Represents an active network request or process
  const ApiResponse.loading() : this._(status: Status.loading);

  // Represents a successful operation, carrying the resulting data
  const ApiResponse.completed(T data)
    : this._(status: Status.completed, data: data);

  // Represents a failed operation, carrying a descriptive error message
  const ApiResponse.error(String message)
    : this._(status: Status.error, message: message);

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}
