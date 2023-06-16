part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final String msg;
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final Password confirmPassword;
  final String username;

  const SignupState(
      {this.msg = '',
      this.status = FormzSubmissionStatus.initial,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.confirmPassword = const Password.pure(),
      this.username = ''});

  @override
  List<Object?> get props => [msg, status, email, password, confirmPassword, username];

  SignupState copyWith(
      {String? msg,
      FormzSubmissionStatus? status,
      Email? email,
      Password? password,
      Password? confirmPassword,
      String? username}) {
    return SignupState(
        msg: msg ?? this.msg,
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        username: username ?? this.username);
  }
}
