part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

// is in signup Screen
class IsInSignUpScreenState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthanticatedState extends AuthState {
  final UserModel userModel;
  AuthanticatedState({
    required this.userModel,
  });
  @override
  List<Object?> get props => [userModel];
}

class UnAuthanticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final AuthError authError;
  AuthErrorState({
    required this.authError,
  });
  @override
  List<Object?> get props => [authError];
}
