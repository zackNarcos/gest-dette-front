import 'package:d_liv/blocs/transactions/transactions_bloc.dart';
import 'package:d_liv/models/repositories/transactions/transactions_repository.dart';
import 'package:d_liv/models/repositories/users/users_repository.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'blocs/auth/auth_bloc.dart';
import 'shared/constants/routes.dart';
import 'models/provider/provider.dart';
import 'models/repositories/auth/auth_repository.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageData().init());

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorWidget = LoadingAnimationWidget.stretchedDots(color: Colors.white, size: 32)
    ..indicatorColor = Colors.white
    ..indicatorSize = 30.0
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 12.0
    ..progressColor = DLivColors.primary
    ..backgroundColor = DLivColors.primary.withOpacity(0.8)
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TransactionsRepository transactionsRepository = TransactionsRepository();
  final AuthRepository authRepository = AuthRepository();
  final UsersRepository usersRepository = UsersRepository();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthRepository()),
        ChangeNotifierProvider(create: (_) => TransactionsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TransactionsBloc>(
            create: (context) => TransactionsBloc(transactionsRepository: transactionsRepository,),
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(authRepository: authRepository, usersRepository: usersRepository),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'D-liv',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            dialogBackgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: Routes.splash,
          getPages: routes,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}