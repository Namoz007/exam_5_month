part of 'user_bloc.dart';

final class UserState extends Equatable {
  UserModel? currentUser;
 

  UserState([this.currentUser]);

  UserState copyWith({
    UserModel? currentUser,
  }) {
    return UserState(currentUser);
  }

  @override
  List<Object?> get props => [currentUser];
}
