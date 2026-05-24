import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_app/features/auth/domain/entity/user_entity.dart';

part 'users_state.freezed.dart';

@freezed
abstract class UsersState with _$UsersState {
  const factory UsersState({
    @Default(false) bool isLoading,
    @Default(false) bool isUserLoading,

    /// pagination
    @Default(false) bool isShowUsersLoader,
    @Default(false) bool hasReachedMaxUsers,

    String? error,
    @Default([]) List<UserEntity> users,
    UserEntity? user,
  }) = _UsersState;
}
