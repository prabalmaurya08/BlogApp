// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//this section will directly interact with external database or APi

abstract interface class AuthRemoteDatasource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithEmailPassword();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<String> loginWithEmailPassword() {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required name,
    required String email,
    required String password,
  }) async {
    try {
      print('========== SIGNUP ATTEMPT ==========');
      print('Attempting to sign up user with:');
      print('Email: $email');
      print('Name: $name');
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      print('Supabase auth.signUp response received:');
      print('Response user: ${response.user}');
      print('Response session: ${response.session}');
      if (response.user == null) {
        throw ServerException(message: "User is Null");
      }

      print('SUCCESS: User created with ID: ${response.user!.id}');
      print('User email: ${response.user!.email}');
      print('User metadata: ${response.user!.userMetadata}');
      print('=======================================');
      return response.user!.id;
    } catch (e) {
      print('========== SIGNUP ERROR ==========');
      print('Error during signup: $e');
      print('===================================');
      throw ServerException(message: e.toString());
    }
  }
}
