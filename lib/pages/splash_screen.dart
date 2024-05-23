import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/components/tabs.dart';
import 'package:expense_tracker/pages/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat(reverse: true);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextScreen(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool showWelcomeScreen = preferences.getBool('showWelcomeScreen') ?? true;
    if (showWelcomeScreen) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TabsController()));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      navigateToNextScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(149, 213, 178,1),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: _splashScreen(),
        ),
      ),
    );
  }

  Widget _splashScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'images/budget.png',
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        Text(
          'Expense Manager',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '0.0.1',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 30),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 0, 0, 0)),
        ),
      ],
    );
  }
}
