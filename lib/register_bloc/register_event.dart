part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class VerifySubmitted extends RegisterEvent {
  final String phone;
  final String firstName;
  final String lastName;
  final String password;
  final String email;

  const VerifySubmitted(
      {@required this.phone,
      @required this.firstName,
      @required this.password,
      @required this.lastName,
      @required this.email});

  @override
  List<Object> get props => [phone, firstName, lastName, email, password];

  @override
  String toString() =>
      'RegisterButtonPressed { phone: $phone, password: $password }';
}

class RegisterButtonPressed extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  const RegisterButtonPressed(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.phone,
      @required this.password});

  @override
  List<Object> get props => [firstName, lastName, phone];

  @override
  String toString() =>
      'RegisterButtonPressed { username: $firstName, phone: $phone }';
}
