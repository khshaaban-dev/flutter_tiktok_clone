part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class IntitlizeEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

// go to signup screen
class GoToSignUpScreenEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

// go to signin screen
class GoToSignInScreenEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String imageUrl;
  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.imageUrl,
  });
  @override
  List<Object> get props => [
        name,
        email,
        password,
        imageUrl,
      ];
}

class SignInWithGoogleEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
