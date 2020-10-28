class ServerError {
  bool hasError;
  List<ErrorsMessage> errorsMessage;
  int code;

  ServerError({this.hasError, this.errorsMessage, this.code});

  ServerError.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    if (json['errorsMessage'] != null) {
      errorsMessage = new List<ErrorsMessage>();
      json['errorsMessage'].forEach((v) {
        errorsMessage.add(new ErrorsMessage.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasError'] = this.hasError;
    if (this.errorsMessage != null) {
      data['errorsMessage'] =
          this.errorsMessage.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class ErrorsMessage {
  String field;
  String message;

  ErrorsMessage({this.field, this.message});

  ErrorsMessage.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['message'] = this.message;
    return data;
  }
}
