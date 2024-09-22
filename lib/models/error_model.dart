
class ErrorResponse {
  final String message;
  final String error;
  final String statusCode;

  ErrorResponse({required this.message, required this.error, required this.statusCode});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'],
      error: json['error'],
      statusCode: json['statusCode'],
    );
  }
}
