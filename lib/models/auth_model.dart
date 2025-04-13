class AuthModel {
  AuthModel({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final num status;
  static const String statusKey = "status";

  final bool success;
  static const String successKey = "success";

  final String message;
  static const String messageKey = "message";

  final Data? data;
  static const String dataKey = "data";

  final List<Error> errors;
  static const String errorsKey = "errors";

  AuthModel copyWith({
    num? status,
    bool? success,
    String? message,
    Data? data,
    List<Error>? errors,
  }) {
    return AuthModel(
      status: status ?? this.status,
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      errors: errors ?? this.errors,
    );
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json["status"] ?? 0,
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errors: json["errors"] == null
          ? []
          : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
    );
  }
}

class Data {
  Data({
    required this.token,
    required this.user,
  });

  final String token;
  static const String tokenKey = "token";

  final User? user;
  static const String userKey = "user";

  Data copyWith({
    String? token,
    User? user,
  }) {
    return Data(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json["token"] ?? "",
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

class User {
  User({
    required this.email,
    required this.role,
    required this.id,
  });

  final String email;
  static const String emailKey = "email";

  final String role;
  static const String roleKey = "role";

  final String id;
  static const String idKey = "_id";

  User copyWith({
    String? email,
    String? role,
    String? id,
  }) {
    return User(
      email: email ?? this.email,
      role: role ?? this.role,
      id: id ?? this.id,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"] ?? "",
      role: json["role"] ?? "",
      id: json["_id"] ?? "",
    );
  }
}

class Error {
  Error({
    required this.path,
    required this.message,
  });

  final String path;
  static const String pathKey = "path";

  final String message;
  static const String messageKey = "message";

  Error copyWith({
    String? path,
    String? message,
  }) {
    return Error(
      path: path ?? this.path,
      message: message ?? this.message,
    );
  }

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      path: json["path"] ?? "",
      message: json["message"] ?? "",
    );
  }
}
