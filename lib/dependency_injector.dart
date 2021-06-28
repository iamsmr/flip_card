import 'package:flash_card/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';

List<RepositoryProvider> repositorys = [
  RepositoryProvider<AuthRepository>(
    create: (context) => AuthRepository(),
  ),
  RepositoryProvider<ProfileRepository>(
    create: (context) => ProfileRepository(),
  ),
  RepositoryProvider<StorageRepository>(
    create: (context) => StorageRepository(),
  ),
  RepositoryProvider<DecksRepository>(
    create: (context) => DecksRepository(),
  )
];

List<BlocProvider> blocks = [
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(
      authRepository: context.read<AuthRepository>(),
    ),
  ),
  BlocProvider<ProfileBloc>(
    create: (context) => ProfileBloc(
        decksRepository: context.read<DecksRepository>(),
        authBloc: context.read<AuthBloc>(),
        profileRepository: context.read<ProfileRepository>())
      ..add(ProfileLoadUser(userId: context.read<AuthBloc>().state.user!.uid)),
  )
];
