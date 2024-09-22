import 'dart:ffi';

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? surname;
  final String? email;
  final String? phone;
  final String? address;
  final int? balance;
  final bool? deleted;
  final bool? isActivate;
  final String? lastLogin;
  final List<dynamic>? roles;
  final String? resetPasswordToken;
  final String? resetPasswordExpires;

  User({this.id, this.firstName, this.surname, this.balance, this.address, this.lastName, this.email, this.phone, this.deleted, this.isActivate, this.lastLogin, this.roles, this.resetPasswordToken, this.resetPasswordExpires});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      surname: json['surname'],
      phone: json['phone'],
      address: json['address'],
      balance: json['balance'],
      isActivate: json['isActivate'],
      deleted: json['deleted'],
      roles: json['roles'],
      lastLogin: json['lastLogin'],
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
    'balance': balance,
    'address': address,
    'deleted': deleted,
    'isActivate': isActivate,
    'lastLogin': lastLogin,
    'roles': roles,
    'resetPasswordToken': resetPasswordToken,
    'resetPasswordExpires': resetPasswordExpires,
  };

  copyWith({required String firstName, required String lastName,required String surname}) {
    return User(
      id: this.id,
      firstName: firstName,
      lastName: lastName,
      surname: surname,
      email: this.email,
      phone: this.phone,
      address: this.address,
      balance: this.balance,
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
  final User user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
