import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            SvgPicture.asset(
              'assets/images/icons/sync.svg',
              height: 250,
            ),
            const Center(child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              backgroundColor: Colors.grey,
              minHeight: 5,
            )),
            const SizedBox(height: 20),
            const Text('Syncing data, please wait...'),
          ],
        ),
      ),
    ));
  }
}