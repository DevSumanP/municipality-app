import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:municipality_app/core/constants/sizes.dart';
import 'package:municipality_app/presentation/providers/auth_provider.dart';
import 'package:municipality_app/presentation/screens/onboarding/onboarding.dart';
import 'package:municipality_app/presentation/screens/home/home_screen.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../providers/sync_provider.dart';

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

  @override
  void initState() {
    super.initState();
    // Listen for auth state changes in the build method instead
  }

  void _navigateAfterLogin() {
  if (!mounted) return;
  
  ref.read(syncRepositoryProvider).needsSync().then((needsSyncResult) {
    if (!mounted) return;
    
    if (needsSyncResult.isRight() && needsSyncResult.getOrElse(() => false)) {
      // If sync is needed, show OnBoardingScreen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
        (route) => false,
      );
    } else {
      // If no sync needed or error occurred, go to HomeScreen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }).catchError((error) {
    // If there's an error, just go to HomeScreen
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  });
}

  void _togglePasswordVisibility() {
    setState(() => hidePassword = !hidePassword);
  }

  Future<void> _onLogin() async {
    if (_formKey.currentState!.validate()) {
      ref.read(authProvider.notifier).clearError();
      await ref.read(authProvider.notifier).login(
            emailController.text.trim().toLowerCase(),
            passwordController.text.trim(),
          );
    }
  }
  
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // Add auth state listener
    ref.listen(authProvider, (previous, next) {
      if (previous?.isAuthenticated != true && next.isAuthenticated) {
        _navigateAfterLogin();
      }
    });

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
              enabled: !authState.isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!AppUtils.isValidEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: 'E-Mail',
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              controller: passwordController,
              obscureText: hidePassword,
              onChanged: onFieldChanged,
              enabled: !authState.isLoading,
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
                      onChanged: authState.isLoading
                          ? null
                          : (val) => setState(() => rememberMe = val ?? false),
                    ),
                    const Text('Remember Me'),
                  ],
                ),
                TextButton(
                  onPressed: authState.isLoading
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Forgot password feature coming soon'),
                            ),
                          );
                        },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 13, color: Color(0xff4b5ae4)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authState.isLoading ? null : _onLogin,
                child: authState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Sign In'),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: authState.isLoading
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Account creation feature coming soon'),
                          ),
                        );
                      },
                child: const Text('Create Account'),
              ),
            ),

            // Error message container (unified)
            if (authState.hasError) ...[
              const SizedBox(height: AppSizes.spaceBtwItems),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Text(
                  authState.error ?? 'Unknown error',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
