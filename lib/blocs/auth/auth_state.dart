import 'package:d_liv/shared/enums/auth_status.dart';
import 'package:d_liv/models/entity/user_model.dart';
import 'package:equatable/equatable.dart';

final class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.status = AuthStatus.unknown,
    this.error,
    this.token,
    this.isLoading = false,
  });

  final User? user;
  final AuthStatus status;
  final String? error;
  final String? token;
  final bool isLoading;

  @override
  List<Object?> get props => [user, status, error, token, isLoading];

  AuthState copyWith({
    User? user,
    AuthStatus? status,
    String? error,
    String? token,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}