class BaseError {
  String? errorMessage;
  String? status;

  BaseError({this.errorMessage, this.status});

  BaseError.fromJson(Map<String, dynamic> json) {
    errorMessage = json['message'];
    status = json['status'];
  }
}
