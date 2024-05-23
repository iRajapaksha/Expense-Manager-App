import 'package:expense_tracker/components/tabs.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(149, 213, 178,1),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _welcomePage(screenWidth, screenHeight, 'images/budget.png', 'Welcome to Expense Manager', 'Manage your expenses efficiently.'),
              _welcomePage(screenWidth, screenHeight, 'images/spending.png', 'Track Your Spending', 'Keep track of your daily expenses.'),
              _welcomePage(screenWidth, screenHeight, 'images/income.png', 'Analyze Your Data', 'Get insights into your spending patterns.'),
            ],
          ),
          Positioned(
            bottom: screenHeight * 0.15,
            left: screenWidth * 0.4,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.black,
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 2,
                spacing: 4,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.35,
            bottom: screenHeight * 0.05,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TabsController()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 15, 4, 24)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              ),
              child: const Text('Let\'s Start',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _welcomePage(double screenWidth, double screenHeight, String image, String heading, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: screenWidth * 0.5,
          height: screenHeight * 0.3,
        ),
        const SizedBox(height: 30),
        Text(
          heading,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
