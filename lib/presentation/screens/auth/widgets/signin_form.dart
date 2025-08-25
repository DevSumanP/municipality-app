import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:municipality_app/core/constants/sizes.dart';
import 'package:municipality_app/presentation/providers/auth_provider.dart';

import '../../../../core/utils/app_utils.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void _onRememberMeChanged(bool? value) {
    setState(() {
      rememberMe = value ?? false;
    });
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authProvider.notifier).login(
            emailController.text.trim(),
            passwordController.text.trim(),
          );
    }
  }

  void _onForgotPassword() {
    
  }

  void _onSignup() {
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: emailController,
              validator: (value) => AppUtils.isValidEmail(value?? '') ? null : 'Please enter a valid email address',
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: 'E-Mail',
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              obscureText: hidePassword,
              controller: passwordController,
              validator: (value) => AppUtils.isValidPassword(value?? '') ? null : 'Please enter a valid password' ,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Iconsax.direct),
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(hidePassword ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields / 2),

            // Remember Me & Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: _onRememberMeChanged,
                    ),
                    const Text('Remember Me'),
                  ],
                ),

                //  Forgot Password
                TextButton(
                  onPressed: _onForgotPassword,
                  child: const Text('Forgot Password?', style: TextStyle(fontSize: 13, color: Color(0xff4b5ae4))),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ref.watch(authProvider).isLoading ? null : _onLogin,
                child: ref.watch(authProvider).isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Sign In'),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            // Sign Up
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _onSignup,
                child: const Text('Create Account'),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
