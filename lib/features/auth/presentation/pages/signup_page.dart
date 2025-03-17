import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (contex) => LoginPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              AuthTextForm(hintText: "Name", controller: nameController),
              SizedBox(height: 10),
              AuthTextForm(hintText: "Email", controller: emailController),
              SizedBox(height: 10),
              AuthTextForm(
                hintText: "Password",
                controller: passwordController,
                obscurePass: true,
              ),
              SizedBox(height: 20),

              // Add this somewhere in your UI temporarily to test
              AuthButton(
                btnText: "SignUp",
                onPressed: () {
                  print("Signup button clicked");

                  if (formKey.currentState!.validate()) {
                    final name = nameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (name.isEmpty || email.isEmpty || password.isEmpty) {
                      print("Error: Name, email, or password cannot be empty!");
                      return; // Stop execution if fields are empty
                    }

                    print("Signing up with: Name = $name, Email = $email");

                    context.read<AuthBloc>().add(
                      AuthSignup(name: name, email: email, password: password),
                    );
                  }
                },
              ),

              GestureDetector(
                onTap: () => {Navigator.push(context, SignUpPage.route())},
                child: RichText(
                  text: TextSpan(
                    text: "Already have Account ? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "SignIn",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppPallete.gradient1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
