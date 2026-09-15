import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/services/shared_preferences_service.dart';
import 'package:nexus/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState>{

  final SharedPreferencesService _preferencesService;
  AuthCubit(this._preferencesService)
      :super(const AuthState());
//التحقق من التسجيل
  Future<void> checkLoginStatus( ) async{
    emit(const AuthState(isLoading: true));
    final isLoggedIn = await _preferencesService.getLogin();
    emit(
        AuthState(
          isLoggedIn: isLoggedIn,


    ),);

  }
  // تسجل الدخول
  Future<void> login(String email, String password) async {

    emit(
      const AuthState(
        isLoading: true,
      ),
    );

    await _preferencesService.saveLogin(true);

    emit(
      const AuthState(
        isLoggedIn: true,
      ),
    );
  }
  //تسجيل الخروج

  Future<void> logout() async {
    await _preferencesService.saveLogin(false);

    emit(
      const AuthState(
        isLoggedIn: false,
      ),
    );
  }

}