// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignup extends AuthEvent {
  final String name;
  final String email;
  final String password;
  AuthSignup({required this.name, required this.email, required this.password});
}
