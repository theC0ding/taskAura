import 'package:flutter_bloc/flutter_bloc.dart';

import 'registration.event.dart';
import 'registration.state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial());

  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationButtonPressed) {
      yield RegistrationLoading();
      await Future.delayed(const Duration(seconds: 2));
      if (event.password != event.confirmPassword) {
        yield RegistrationFailure(message: 'Passwords do not match');
      } else {
        yield RegistrationSuccess();
      }
    }
  }
}
