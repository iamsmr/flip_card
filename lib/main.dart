import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_card/blocs/auth/auth_bloc.dart';
import 'package:flash_card/blocs/blocs.dart';
import 'package:flash_card/blocs/bloc_observer.dart';
import 'package:flash_card/config/custom_route.dart';
import 'package:flash_card/repositories/repositories.dart';
import 'package:flash_card/dependency_injector.dart';
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
      providers: repositorys,
      child: MultiBlocProvider(
        providers: blocks,
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
