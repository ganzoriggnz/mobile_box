import 'dart:async';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mobilbox/authentication/authentication.dart';
import 'package:mobilbox/repositories/repositories.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.login(
          event.email,
          event.password,
        );
        if(token != null){
          authenticationBloc.add(LoggedIn(token: token));
          yield LoginInitial();
        } else {
          yield LoginFailure(error: 'Нэр эсвэл нууц үг буруу байна.');
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
