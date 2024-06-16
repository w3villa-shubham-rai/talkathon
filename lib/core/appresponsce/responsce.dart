

import 'package:talkathon/utils/enumtype.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse.loading() : status = Status.WAITING;
  ApiResponse.error(this.message) : status = Status.ERROR;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  @override
  String toString() {
    return "Status: $status, Data: $data, Message: $message";
  }
}
