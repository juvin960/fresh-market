import 'package:get_it/get_it.dart';

import '../auth/model/auth_model.dart';
import '../auth/view_model/auth_view-model.dart';
import '../screens/product/product_category/category_model.dart';
import '../screens/product/product_category/category_view_model.dart';
import '../screens/product/product_list/product.model.dart';
import '../screens/product/product_list/product_view_model.dart';
import 'api_client.dart';


final sl = GetIt.instance;

void setupServiceLocator() {
  const String baseUrl = 'http://10.118.159.207:8000/api';

  sl.registerLazySingleton<ApiClient>(() => ApiClient(baseUrl: baseUrl));

  sl.registerLazySingleton<AuthModel>(() => AuthModel(sl<ApiClient>()));
  sl.registerLazySingleton<AuthViewModel>(() => AuthViewModel(sl<AuthModel>()));

  sl.registerLazySingleton<CategoryModel>(() => CategoryModel(sl<ApiClient>()));
  sl.registerLazySingleton<CategoryViewModel>(() => CategoryViewModel(sl<CategoryModel>()));

  sl.registerLazySingleton<ProductModel>(() => ProductModel(sl<ApiClient>()));
  sl.registerLazySingleton<ProductViewModel>(() => ProductViewModel(sl<ProductModel>()));
}