// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:store_app/core/di/modules/network_module.dart' as _i345;
import 'package:store_app/core/di/modules/shared_pref_module.dart' as _i420;
import 'package:store_app/core/network/http_interceptors.dart' as _i986;
import 'package:store_app/core/services/auth_session_manager.dart' as _i702;
import 'package:store_app/core/services/geolocation_service.dart' as _i436;
import 'package:store_app/core/services/geolocation_service_interface.dart'
    as _i712;
import 'package:store_app/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i845;
import 'package:store_app/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i934;
import 'package:store_app/features/auth/data/repository/auth_repository_impl.dart'
    as _i263;
import 'package:store_app/features/auth/domain/repository/auth_repository.dart'
    as _i415;
import 'package:store_app/features/auth/domain/usecases/check_auth_usecase.dart'
    as _i660;
import 'package:store_app/features/auth/domain/usecases/get_user_profile_usecase.dart'
    as _i631;
import 'package:store_app/features/auth/domain/usecases/login_usecase.dart'
    as _i264;
import 'package:store_app/features/auth/domain/usecases/logout_usecase.dart'
    as _i342;
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart'
    as _i706;
import 'package:store_app/features/locations/data/data_sources/locations_remote_data_source.dart'
    as _i253;
import 'package:store_app/features/locations/data/repository/locations_repository_impl.dart'
    as _i1007;
import 'package:store_app/features/locations/domain/repository/locations_repository.dart'
    as _i192;
import 'package:store_app/features/locations/domain/usecases/fetch_locations_usecase.dart'
    as _i965;
import 'package:store_app/features/locations/presentation/bloc/locations_bloc.dart'
    as _i999;
import 'package:store_app/features/products/data/data_sources/products_remote_data_source.dart'
    as _i456;
import 'package:store_app/features/products/data/repository/products_repository_impl.dart'
    as _i1027;
import 'package:store_app/features/products/domain/repository/products_repository.dart'
    as _i891;
import 'package:store_app/features/products/domain/usecases/create_category_usecase.dart'
    as _i959;
import 'package:store_app/features/products/domain/usecases/create_product_usecase.dart'
    as _i100;
import 'package:store_app/features/products/domain/usecases/delete_category_usecase.dart'
    as _i778;
import 'package:store_app/features/products/domain/usecases/delete_product_usecase.dart'
    as _i422;
import 'package:store_app/features/products/domain/usecases/fetch_categories_usecase.dart'
    as _i657;
import 'package:store_app/features/products/domain/usecases/fetch_product_usecase.dart'
    as _i696;
import 'package:store_app/features/products/domain/usecases/fetch_products_usecase.dart'
    as _i895;
import 'package:store_app/features/products/domain/usecases/fetch_related_by_id_usecase.dart'
    as _i997;
import 'package:store_app/features/products/domain/usecases/upload_image_usecase.dart'
    as _i577;
import 'package:store_app/features/products/presentation/bloc/products_bloc.dart'
    as _i287;
import 'package:store_app/features/theme/cubit/cubit.dart' as _i969;
import 'package:store_app/features/theme/data/data_sources/theme_local_data_source.dart'
    as _i625;
import 'package:store_app/features/theme/data/repository/theme_repository_impl.dart'
    as _i629;
import 'package:store_app/features/theme/domain/repository/theme_repository.dart'
    as _i892;
import 'package:store_app/features/theme/domain/usecases/get_theme_usecase.dart'
    as _i689;
import 'package:store_app/features/theme/domain/usecases/set_theme_usecase.dart'
    as _i12;
import 'package:store_app/features/users/data/data_sources/users_remote_data_source.dart'
    as _i933;
import 'package:store_app/features/users/data/repository/users_repository_impl.dart'
    as _i294;
import 'package:store_app/features/users/domain/repository/users_repository.dart'
    as _i666;
import 'package:store_app/features/users/domain/usecases/fetch_user_usecase.dart'
    as _i617;
import 'package:store_app/features/users/domain/usecases/fetch_users_usecase.dart'
    as _i623;
import 'package:store_app/features/users/presentation/bloc/users_bloc.dart'
    as _i1011;
import 'package:store_app/navigation/router.dart' as _i634;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPrefModule = _$SharedPrefModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i986.ErrorInterceptor>(() => _i986.ErrorInterceptor());
    gh.lazySingleton<_i702.AuthSessionManager>(
      () => _i702.AuthSessionManager(),
    );
    gh.lazySingleton<_i712.IGeolocationService>(
      () => _i436.GeolocationService(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.refreshDio(),
      instanceName: 'refresh_dio',
    );
    gh.lazySingleton<_i845.AuthLocalDataSource>(
      () => _i845.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i625.ThemeLocalDataSource>(
      () => _i625.ThemeLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i986.AuthInterceptor>(
      () => _i986.AuthInterceptor(
        gh<_i845.AuthLocalDataSource>(),
        gh<_i702.AuthSessionManager>(),
        gh<_i361.Dio>(instanceName: 'refresh_dio'),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i986.AuthInterceptor>(),
        gh<_i986.ErrorInterceptor>(),
      ),
    );
    gh.lazySingleton<_i892.ThemeRepository>(
      () => _i629.ThemeRepositoryImpl(
        themeLocalDataSource: gh<_i625.ThemeLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i934.AuthRemoteDataSource>(
      () => _i934.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i415.AuthRepository>(
      () => _i263.AuthRepositoryImpl(
        authLocalDataSource: gh<_i845.AuthLocalDataSource>(),
        authRemoteDataSource: gh<_i934.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i456.ProductsRemoteDataSource>(
      () => _i456.ProductsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i689.GetThemeUseCase>(
      () => _i689.GetThemeUseCase(gh<_i892.ThemeRepository>()),
    );
    gh.lazySingleton<_i12.SetThemeUseCase>(
      () => _i12.SetThemeUseCase(gh<_i892.ThemeRepository>()),
    );
    gh.lazySingleton<_i253.LocationsRemoteDataSource>(
      () => _i253.LocationsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i933.UsersRemoteDataSource>(
      () => _i933.UsersRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i192.LocationsRepository>(
      () => _i1007.LocationsRepositoryImpl(
        locationsRemoteDataSource: gh<_i253.LocationsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i891.ProductsRepository>(
      () => _i1027.ProductsRepositoryImpl(
        productsRemoteDataSource: gh<_i456.ProductsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i965.FetchLocationsUseCase>(
      () => _i965.FetchLocationsUseCase(gh<_i192.LocationsRepository>()),
    );
    gh.lazySingleton<_i660.CheckAuthUseCase>(
      () => _i660.CheckAuthUseCase(gh<_i415.AuthRepository>()),
    );
    gh.lazySingleton<_i631.GetUserProfileUseCase>(
      () => _i631.GetUserProfileUseCase(gh<_i415.AuthRepository>()),
    );
    gh.lazySingleton<_i264.LoginUseCase>(
      () => _i264.LoginUseCase(gh<_i415.AuthRepository>()),
    );
    gh.lazySingleton<_i342.LogoutUseCase>(
      () => _i342.LogoutUseCase(gh<_i415.AuthRepository>()),
    );
    gh.lazySingleton<_i959.CreateCategoryUseCase>(
      () => _i959.CreateCategoryUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i100.CreateProductUseCase>(
      () => _i100.CreateProductUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i778.DeleteCategoryUseCase>(
      () => _i778.DeleteCategoryUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i422.DeleteProductUseCase>(
      () => _i422.DeleteProductUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i657.FetchCategoriesUseCase>(
      () => _i657.FetchCategoriesUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i696.FetchProductUseCase>(
      () => _i696.FetchProductUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i895.FetchProductsUseCase>(
      () => _i895.FetchProductsUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i997.FetchRelatedByIdUseCase>(
      () => _i997.FetchRelatedByIdUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i577.UploadImageUseCase>(
      () => _i577.UploadImageUseCase(gh<_i891.ProductsRepository>()),
    );
    gh.lazySingleton<_i666.UsersRepository>(
      () => _i294.UsersRepositoryImpl(
        productsRemoteDataSource: gh<_i933.UsersRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i969.ThemeCubit>(
      () => _i969.ThemeCubit(
        getThemeUseCase: gh<_i689.GetThemeUseCase>(),
        setThemeUseCase: gh<_i12.SetThemeUseCase>(),
      ),
    );
    gh.lazySingleton<_i999.LocationsBloc>(
      () => _i999.LocationsBloc(
        fetchLocationsUseCase: gh<_i965.FetchLocationsUseCase>(),
        geolocationService: gh<_i712.IGeolocationService>(),
      ),
    );
    gh.lazySingleton<_i617.FetchUserUseCase>(
      () => _i617.FetchUserUseCase(gh<_i666.UsersRepository>()),
    );
    gh.lazySingleton<_i623.FetchUsersUseCase>(
      () => _i623.FetchUsersUseCase(gh<_i666.UsersRepository>()),
    );
    gh.lazySingleton<_i287.ProductsBloc>(
      () => _i287.ProductsBloc(
        fetchProductsUseCase: gh<_i895.FetchProductsUseCase>(),
        fetchCategoriesUseCase: gh<_i657.FetchCategoriesUseCase>(),
        fetchProductUseCase: gh<_i696.FetchProductUseCase>(),
        fetchRelatedByIdUseCase: gh<_i997.FetchRelatedByIdUseCase>(),
        uploadImageUseCase: gh<_i577.UploadImageUseCase>(),
        createProductUseCase: gh<_i100.CreateProductUseCase>(),
        deleteProductUseCase: gh<_i422.DeleteProductUseCase>(),
        createCategoryUseCase: gh<_i959.CreateCategoryUseCase>(),
        deleteCategoryUseCase: gh<_i778.DeleteCategoryUseCase>(),
      ),
    );
    gh.lazySingleton<_i706.AuthBloc>(
      () => _i706.AuthBloc(
        loginUseCase: gh<_i264.LoginUseCase>(),
        logoutUseCase: gh<_i342.LogoutUseCase>(),
        checkAuthUseCase: gh<_i660.CheckAuthUseCase>(),
        getUserProfileUseCase: gh<_i631.GetUserProfileUseCase>(),
      ),
    );
    gh.lazySingleton<_i1011.UsersBloc>(
      () => _i1011.UsersBloc(
        fetchUsersUseCase: gh<_i623.FetchUsersUseCase>(),
        fetchUserUseCase: gh<_i617.FetchUserUseCase>(),
      ),
    );
    gh.lazySingleton<_i634.AppRouter>(
      () => _i634.AppRouter(gh<_i706.AuthBloc>()),
    );
    return this;
  }
}

class _$SharedPrefModule extends _i420.SharedPrefModule {}

class _$NetworkModule extends _i345.NetworkModule {}
