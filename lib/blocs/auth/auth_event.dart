import 'package:d_liv/models/entity/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AppInit extends AuthEvent {}

class CheckIfIsFirstTime extends AuthEvent {}

class FetchUserData extends AuthEvent {}

class SignUpGuest extends AuthEvent {
  final User guest;

  SignUpGuest({required this.guest});

  @override
  List<Object> get props => [guest];
}

class LoginPhone extends AuthEvent {
  final String phone;

  LoginPhone({required this.phone});

  @override
  List<Object> get props => [phone];
}

class VerifyPhone extends AuthEvent {
  final String phone;
  final String code;

  VerifyPhone({required this.phone, required this.code});

  @override
  List<Object> get props => [phone, code];
}

class LoginEmail extends AuthEvent {
  final String email;
  final String password;

  LoginEmail({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class UpdateUser extends AuthEvent {
  final String firstName;
  final String lastName;

  UpdateUser({required this.firstName, required this.lastName});

  @override
  List<Object> get props => [firstName, lastName];
}

class ResetState extends AuthEvent {}