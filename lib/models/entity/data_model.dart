import 'dart:ffi';

class DataModel {
  final String id;
  final String firstName;
  final String lastName;
  final String surname;
  final String email;
  final String phone;
  final bool? deleted;
  final bool? isActivate;
  final String? lastLogin;
  final List<dynamic> roles;
  final String? resetPasswordToken;
  final String? resetPasswordExpires;

  DataModel({required this.id, required this.firstName, required this.surname, required this.lastName, required this.email, required this.phone, required this.deleted, required this.isActivate, required this.lastLogin, required this.roles, required this.resetPasswordToken, required this.resetPasswordExpires});


  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      surname: json['surname'],
      email: json['email'],
      phone: json['phone'],
      deleted: json['deleted'],
      isActivate: json['isActivate'],
      lastLogin: json['lastLogin'],
      roles: json['roles'],
      resetPasswordToken: json['resetPasswordToken'],
      resetPasswordExpires: json['resetPasswordExpires'],
    );
  }


  get toJson => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'surname': surname,
    'email': email,
    'phone': phone,
    'deleted': deleted,
    'isActivate': isActivate,
    'lastLogin': lastLogin,
    'roles': roles,
    'resetPasswordToken': resetPasswordToken,
    'resetPasswordExpires': resetPasswordExpires,
  };

  copyWith({required String firstName, required String lastName,required String surname}) {
    return DataModel(
      id: this.id,
      firstName: firstName,
      lastName: lastName,
      surname: surname,
      email: this.email,
      phone: this.phone,
      deleted: this.deleted,
      isActivate: this.isActivate,
      lastLogin: this.lastLogin,
      roles: this.roles,
      resetPasswordToken: this.resetPasswordToken,
      resetPasswordExpires: this.resetPasswordExpires,
    );
  }

}

class AuthResponse {
  final String token;
  final DataModel user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: DataModel.fromJson(json['user']),
    );
  }
}
