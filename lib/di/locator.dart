
import 'package:get_it/get_it.dart';
import 'package:katra/api_manager/client.dart';
import 'package:katra/repos/forget_password_repo.dart';
import 'package:katra/repos/login_repo.dart';
import 'package:katra/repos/profile_repo.dart';
import 'package:katra/repos/signup_repo.dart';
import 'package:katra/ui/screens/forget_password_page/forget_password_bloc.dart';
import 'package:katra/ui/screens/homepage_page/homepage_bloc.dart';
import 'package:katra/ui/screens/login_page/login_bloc.dart';
import 'package:katra/ui/screens/profile_page/profile_bloc.dart';
import 'package:katra/ui/screens/signup_page/signup_bloc.dart';

import '../db_manager/local_storage_service.dart';
import '../repos/homepage_repo.dart';

final getItLocator=GetIt.instance;
Future<void> setupLocator() async {
  //service locator
  //sequential order is important

  //Network Client
  getItLocator.registerLazySingleton<Client>(() => Client());
  //Repo
  getItLocator.registerLazySingleton<LoginRepo>(() => LoginRepo(getItLocator.get<Client>()));
  getItLocator.registerLazySingleton<SignupRepo>(() => SignupRepo(getItLocator.get<Client>()));
  getItLocator.registerLazySingleton<ForgetPasswordRepo>(() => ForgetPasswordRepo(getItLocator.get<Client>()));
  getItLocator.registerLazySingleton<HomepageRepo>(() => HomepageRepo(getItLocator.get<Client>()));
  getItLocator.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getItLocator.get<Client>()));
  //Blocs
  getItLocator.registerLazySingleton<LoginBloc>(() => LoginBloc(getItLocator.get<LoginRepo>()));
  getItLocator.registerLazySingleton<SignupBloc>(() => SignupBloc(getItLocator.get<SignupRepo>()));
  getItLocator.registerLazySingleton<ForgetPasswordBloc>(() => ForgetPasswordBloc(getItLocator.get<ForgetPasswordRepo>()));
  getItLocator.registerLazySingleton<HomepageBloc>(() => HomepageBloc(getItLocator.get<HomepageRepo>()));
  getItLocator.registerLazySingleton<ProfileBloc>(() => ProfileBloc(getItLocator.get<ProfileRepo>()));

}