import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Simulate some initialization or loading process
    await Future.delayed(const Duration(seconds: 3));

    try {
      // Navigate to NewsPage and remove SplashScreen from navigation stack

    } catch (e) {
      // Handle any unexpected error during navigation
      print('Error navigating to NewsPage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your logo widget or image
            Image.network(
              'https://media.istockphoto.com/id/1330788505/vector/news-paper-care-logo-template-design.jpg?s=612x612&w=0&k=20&c=c9loKIAmPQ06pPh07dJny2iNKEv4BMhMXPZx9AGf8VE=',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
