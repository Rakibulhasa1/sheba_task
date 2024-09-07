import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../utils/local_storage.dart'; // Adjust path if necessary

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLogin) {
      // Handle login logic and state
      await LocalStorage.saveToken('your_token');
      yield AuthLoggedIn();
    } else if (event is AuthLogout) {
      await LocalStorage.removeToken();
      yield AuthLoggedOut();
    }
  }
}
