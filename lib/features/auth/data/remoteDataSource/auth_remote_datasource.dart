// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/model/user_modal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//this section will directly interact with external database or APi

abstract interface class AuthRemoteDatasource {
  Future<UserModal> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModal> loginWithEmailPassword();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<UserModal> loginWithEmailPassword() {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<UserModal> signUpWithEmailPassword({
    required name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      print('Supabase auth.signUp response received:');

      if (response.user == null) {
        throw ServerException(message: "User is Null");
      }

      return UserModal.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
