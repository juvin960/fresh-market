import 'package:get_it/get_it.dart';

import '../auth/model/auth_model.dart';
import '../auth/view_model/auth_view-model.dart';
import 'api_client.dart';


final sl = GetIt.instance;

void setupServiceLocator() {
  const String baseUrl = 'http://192.168.1.175:8000/api';

  sl.registerLazySingleton<ApiClient>(() => ApiClient(baseUrl: baseUrl));

  sl.registerLazySingleton<AuthModel>(() => AuthModel(sl<ApiClient>()));
  sl.registerLazySingleton<AuthViewModel>(() => AuthViewModel(sl<AuthModel>()));
}