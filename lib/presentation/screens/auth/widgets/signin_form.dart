import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:municipality_app/core/constants/sizes.dart';
import 'package:municipality_app/presentation/providers/auth_provider.dart';
import 'package:municipality_app/presentation/screens/onboarding.dart';

import '../../../../core/utils/app_utils.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  bool rememberMe = false;
  String? rememberMeError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => hidePassword = !hidePassword);
  }

  Future<void> _onLogin() async {
    // First validate the form
    // Reset checkbox error
    setState(() => rememberMeError = null);

    // Validate form and checkbox
    if (_formKey.currentState!.validate()) {
      if (!rememberMe) {
        setState(() {
          rememberMeError = 'Please check "Remember Me" to proceed';
        });
        return; // Prevent login if checkbox is unchecked
      }
    }

    // Show loading state
    final notifier = ref.read(authProvider.notifier);

    try {
      await notifier.login(
        emailController.text.trim().toLowerCase(),
        passwordController.text.trim(),
      );
    } finally {
      // Always trigger validation after login attempt completes
      if (_formKey.currentState != null) {
        _formKey.currentState!.validate();
      }
    }

    if (notifier.state.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Clear error when user starts typing
    void onFieldChanged(String value) {
      if (authState.hasError) {
        ref.read(authProvider.notifier).clearError();
      }
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email
            TextFormField(
              controller: emailController,
              onChanged: onFieldChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!AppUtils.isValidEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                labelText: 'E-Mail',
                errorText: authState.error ==
                        "Your credentials don't match our records."
                    ? authState.error
                    : null,
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              controller: passwordController,
              obscureText: hidePassword,
              onChanged: onFieldChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (!AppUtils.isValidPassword(value)) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Iconsax.lock),
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(hidePassword ? Iconsax.eye_slash : Iconsax.eye),
                ),
                errorText: authState.error ==
                        "Your credentials don't match our records."
                    ? null
                    : authState.error,
                errorMaxLines: 2,
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
                      onChanged: (val) {
                        setState(() {
                          rememberMe = val ?? false;
                          rememberMeError =
                              null; // Clear error when checkbox is toggled
                        });
                      },
                    ),
                    const Text('Remember Me'),
                  ],
                ),
                TextButton(
                  onPressed: () {}, // TODO: forgot password
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 13, color: Color(0xff4b5ae4)),
                  ),
                ),
              ],
            ),

            if (rememberMeError != null)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                child: Text(
                  rememberMeError!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),

            const SizedBox(height: AppSizes.spaceBtwSections),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authState.isLoading ? null : _onLogin,
                child: authState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Sign In'),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            // Sign Up
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {}, // TODO: signup
                child: const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
