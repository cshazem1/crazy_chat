import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  Future<void> logInUser(
      {required String email,
      required String password,
      })

  async {
    emit(SignUpLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
emit(SignUpFailure('weak-password'));

      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure('The account already exists for that email.'));

      } else {
        emit(SignUpFailure('The email address is badly formatted'));
      }
    } catch (e) {
      String w = e.toString();
      emit(SignUpFailure(w));
    }
  }
}
