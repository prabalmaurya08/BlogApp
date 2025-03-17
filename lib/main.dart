import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/data/Repository/auth_repository_imp.dart';
import 'package:blog_app/features/auth/data/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/usecase/user_signup.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  print('App starting...');
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => AuthBloc(
                userSignup: UserSignup(
                  authRepository: AuthRepositoryImpl(
                    remoteDatasource: AuthRemoteDatasourceImpl(
                      supabaseClient: supabase.client,
                    ),
                  ),
                ),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,

      home: const SignUpPage(),
    );
  }
}
