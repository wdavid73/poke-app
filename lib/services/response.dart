class Response {
  bool status;
  String message;
  int httpCode;
  dynamic data;

  Response(this.status, this.message, this.httpCode, this.data);

  @override
  String toString() {
    return "Response( httCode: $httpCode, statusCode: $status, message: $message, data: $data)";
  }
}
