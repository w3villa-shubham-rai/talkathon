class SuccessType {
  final int? statusCode;
  final dynamic? data;
  final String? message;
  final bool isSuccess;

  SuccessType({
    this.isSuccess = true,
    this.message,
    this.data,
    this.statusCode,
  });
}
