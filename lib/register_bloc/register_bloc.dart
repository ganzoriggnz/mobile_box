import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:mobilbox/repositories/repositories.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterButtonPressed) {
      yield* _mapFormSubmittedToState(event.firstName, event.lastName, event.phone, event.email, event.password);
    }
  }
  Stream<RegisterState> _mapFormSubmittedToState(
    String firstName,
    String lastName,
    String phone,
    String email,
    String password
    ) async* {
      yield RegisterLoading();
      try {
        Response response = await userRepository.registerPhone(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        password: password
      );
        var resJson = jsonDecode(response.body);
        if(resJson['success'] == true) {
        yield RegisterSuccess();
        } else {
        yield RegisterFailure(error: "Амжилтгүй.");
        }
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
  }
}