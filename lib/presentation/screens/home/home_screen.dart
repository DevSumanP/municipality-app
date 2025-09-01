import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/models/user_model.dart';
import '../../providers/database_provider.dart';
import '../../providers/auth_provider.dart';
import 'dart:io';
import '../../widgets/common/exit_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _showExitBar = false;
  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => ExitDialog(
        onCancel: () => Navigator.of(context).pop(false),
        onExit: () => Navigator.of(context).pop(true),
      ),
    );
    return shouldExit ?? false;
  }

  void _exitApp() {
    // Prefer SystemNavigator.pop on Android; exit(0) is harsher.
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      // iOS apps typically shouldn't programmatically exit.
      // If you still want to mimic exit:
      SystemNavigator.pop(); // or do nothing and just pop a route if applicable
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome, ${user?.name ?? 'User'}',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              if (user != null) _buildUserProfile(user),
              if (user != null) _buildUserContent(user, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(User user) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // CachedNetworkImage(imageUrl: user.image ?? '', width: 100, height: 100, fit: BoxFit.cover ,placeholder: (context, url) => const CircularProgressIndicator(), errorWidget: (context, url, error) => const Icon(Icons.error),),
            Image.asset('assets/images/character.png',
                width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(user.email),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(4.0),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 206, 206, 206)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Icon(Iconsax.call),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.all(4.0),
                            side: const BorderSide(color: Colors.blueAccent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child:
                              const Icon(Iconsax.message, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildUserContent(User user, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              'Email: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              user.email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              'Type: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              user.type,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Header Title: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                user.headerTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
