import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:municipality_app/core/constants/sizes.dart';
import 'package:municipality_app/presentation/providers/auth_provider.dart';
import 'package:municipality_app/presentation/screens/onboarding/onboarding.dart';
import '../../../core/utils/spacing_styles.dart';
import 'widgets/signin_form.dart';
import 'widgets/signin_header.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: SpacingStyles.paddingWithAppBarHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                SvgPicture.asset(
                  'assets/images/auth/auth.svg',
                  height: 150,
                ),
                
                const SizedBox(height: AppSizes.spaceBtwSections),
                // Logo, Title & Sub title
                const LoginHeader(),

                // Form
                const LoginForm(),

                const SizedBox(height: AppSizes.spaceBtwSections),

                // Footer
                //  SocialButtons()
              ],
            )),
      ),
    );
  }
}
