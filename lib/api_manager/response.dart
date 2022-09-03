//generic response class

class APIResponse<T> {
  String? message;
  int? statusCode;
  bool? isSuccessFul;
  T? data;

  APIResponse(this.statusCode, this.isSuccessFul, this.message, this.data);

  factory APIResponse.fromJson(
      Map<String, dynamic> json, Function(dynamic) create) {
    return APIResponse(
        json["status"],
        json["status"] >= 200 && json["status"] <= 299,
        json["message"],
        json["data"] != null ? create(json["data"]) : null);
  }

  Map toJson() => {"statusCode": statusCode, "message": message, "data": data};
}
