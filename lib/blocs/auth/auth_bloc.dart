import 'dart:convert';

import 'package:d_liv/blocs/auth/auth_event.dart';
import 'package:d_liv/blocs/auth/auth_state.dart';
import 'package:d_liv/models/repositories/users/users_repository.dart';
import 'package:d_liv/shared/constants/keys.dart';
import 'package:d_liv/shared/constants/routes.dart';
import 'package:d_liv/shared/enums/auth_status.dart';
import 'package:d_liv/models/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../models/entity/user_model.dart';
import '../../models/provider/provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UsersRepository usersRepository,
  }) : _authRepository = authRepository, _usersRepository = usersRepository,
       super(const AuthState())
  {
    on<AppStarted>(_onAppStarted);
    on<AppInit>(_onAppInit);
    on<CheckIfIsFirstTime>(_onCheckFirstTime);
    on<ResetState>(_onAppReset);
    on<LoginEmail>(_onLoginEmail);
    on<FetchUserData>(_onFetchUserData);
    on<UpdateUser>(_updateUser);
    on<SignUpGuest>(_onSignUpGuest);
  }

  final AuthRepository _authRepository;
  final UsersRepository _usersRepository;
  final StorageData _storageData = Get.find<StorageData>();

  Future<void> _onAppReset(ResetState event, Emitter<AuthState> emit) async {
    //reset storage
    _storageData.write(keyToken, '');
    _storageData.write(keyUser, '');

    emit(state.copyWith(isLoading: false, status: AuthStatus.unknown, error: '', user: null, token: ''));
    // navigate to onboarding screen
    Get.offAndToNamed(Routes.onboarding);
  }

  void _onAppInit(AppInit event, Emitter<AuthState> emit) {
    emit(state.copyWith(isLoading: false, status: AuthStatus.unknown, error: '', user: null, token: ''));
  }

  void _onCheckFirstTime(CheckIfIsFirstTime event, Emitter<AuthState> emit) {
    final isFirstTime = _storageData.read(keyIsFisrtTime);
    if (isFirstTime == null || isFirstTime == '' || isFirstTime == true) {
      _storageData.write(keyIsFisrtTime, false);
    } else {
      Get.offAndToNamed(Routes.auth);
    }
  }



  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final token = _storageData.read(keyToken);
    final user = _storageData.read(keyUser);

    if (token != null && user != null && user != '' && token != '') {
      // get user from api
      emit(state.copyWith(isLoading: true));
      try{
        final response = await _authRepository.fetchUserData();
        final newUser =  User.fromJson(jsonDecode(response.body));
        if (newUser != null) {
          //save user to local storage
          _storageData.write(keyUser, newUser.toJson);
          emit(state.copyWith(status: AuthStatus.authenticated, token: token, user: newUser, isLoading: false));
          // navigate to home screen
          Get.offAndToNamed(Routes.home);
        } else {
          emit(state.copyWith(status: AuthStatus.unauthenticated, isLoading: false));
          // navigate to onboarding screen
          Get.offAndToNamed(Routes.onboarding);
        }
      } catch (err) {
        emit(state.copyWith(status: AuthStatus.unauthenticated, isLoading: false));
        // navigate to onboarding screen
        Get.offAndToNamed(Routes.onboarding);
      }

    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated, isLoading: false));
      // navigate to onboarding screen
      Get.offAndToNamed(Routes.onboarding);
    }
  }

  Future<void> _onFetchUserData(FetchUserData event, Emitter<AuthState> emit) async {

    try{
      final response = await _authRepository.fetchUserData();
      final newUser =  User.fromJson(jsonDecode(response.body));
      //save user to local storage
      _storageData.write(keyUser, newUser.toJson);
      emit(state.copyWith(user: newUser, isLoading: false));
    } catch (err) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLoginEmail(LoginEmail event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _authRepository.loginEmail(event.email, event.password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final authRes = AuthResponse.fromJson(jsonDecode(response.body));
        //save token to local storage
        _storageData.write(keyToken, authRes.token);
        _storageData.write(keyUser, authRes.user.toJson);

        emit(state.copyWith(status: AuthStatus.authenticated, token: authRes.token, user: authRes.user, isLoading: false));
        // navigate to home screen
        Get.offAndToNamed(Routes.home);
      } else {
        final Map<String, dynamic> error = jsonDecode(response.body);
        emit(state.copyWith(error: error['message'], status: AuthStatus.unauthenticated, isLoading: false));
      }
    } catch ( error ) {
      final Map<String, dynamic> err = jsonDecode(error.toString());
      emit(state.copyWith(error: err['message'], status: AuthStatus.unauthenticated, isLoading: false));
    }
  }

  Future<void> _updateUser(UpdateUser event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _usersRepository.update(event.firstName, event.lastName, state.user!.id!);
      emit(state.copyWith(isLoading: false, user: state.user!.copyWith(firstName: event.firstName, lastName: event.lastName, surname: 'surname')));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> _onSignUpGuest(SignUpGuest event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final res = await _usersRepository.registerGuest(event.guest);
      print(res);
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }
}