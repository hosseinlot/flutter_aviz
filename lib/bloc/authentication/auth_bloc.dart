import 'package:aviz_app/bloc/authentication/auth_event.dart';
import 'package:aviz_app/bloc/authentication/auth_state.dart';
import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/repository/authentication_repository.dart';
import 'package:aviz_app/di.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository = locator.get();

  AuthBloc() : super(AuthInitiateState()) {
    on<AuthRegisterRequest>(
      (event, emit) async {
        emit(AuthLoadingState());
        var response = await _authRepository.register(event.username, event.password, event.passwordConfirm);

        if (response is DataSuccess) {
          emit(AuthSuccessState(response.data!));
        }

        if (response is DataFailed) {
          emit(AuthFailedState(response.error!));
        }
      },
    );

    on<AuthLoginRequest>(
      (event, emit) async {
        emit(AuthLoadingState());
        var response = await _authRepository.login(event.username, event.password);

        if (response is DataSuccess) {
          emit(AuthSuccessState(response.data!));
        }

        if (response is DataFailed) {
          emit(AuthFailedState(response.error!));
        }
      },
    );
  }
}
