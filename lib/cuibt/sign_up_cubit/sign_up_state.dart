part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}
class SignUpSuccess extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpFailure extends SignUpState {
 final String massage;
  SignUpFailure(this.massage);
}
