import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

   Future<void> checkLogin(
      {required String email, required String password}) async {
    try{
      emit(LoginLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      emit(LoginSuccess());

    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
emit(LoginFailure(e.code));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(e.code));

      } else if (e.code == 'network-request-failed') {
        emit(LoginFailure(e.code));
      } else {
        emit(LoginFailure("password or email not right."));

      }
    } catch (e) {
      String w = e.toString();
      emit(LoginFailure(w));
    }
  }

}
