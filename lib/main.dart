import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip_card/blocs/auth/auth_bloc.dart';
import 'package:flip_card/config/bloc_observer.dart';
import 'package:flip_card/config/custom_route.dart';
import 'package:flip_card/repositories/repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (context) => StorageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flip Card',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xff8893F1),
            appBarTheme: AppBarTheme(elevation: 0, centerTitle: true),
          ),
          initialRoute: '/splash',
          onGenerateRoute: CoustomRoute.onGenerateRoute,
        ),
      ),
    );
  }
}
