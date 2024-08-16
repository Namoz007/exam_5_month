import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/eleveted_button.dart';
import '../auth_screen/login_screen.dart';

class SecondOnboardingScreen extends StatefulWidget {
  const SecondOnboardingScreen({super.key});

  @override
  _SecondOnboardingScreenState createState() => _SecondOnboardingScreenState();
}

class _SecondOnboardingScreenState extends State<SecondOnboardingScreen> {
  final PageController  _controller = PageController();
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        setState(() {
          isLastPage = _controller.page == 3;
        });
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What`s inside',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '1. Browse thousands of recipes',
                          style: TextStyle(color: Colors.orange, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/splash/second.png',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '2. Save your favorite recipes',
                          style: TextStyle(color: Colors.orange, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/splash/third.png',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '3. Share recipes with friends',
                          style: TextStyle(color: Colors.orange, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/splash/fourt.png',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '4.Share with friends!',
                          style: TextStyle(color: Colors.orange, fontSize: 20),
                        ),
                        Image.asset(
                          'assets/images/splash/fifth.png',
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.orange,
                    dotColor: Colors.grey,
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isLastPage
                  ? ElevetedButtonWidget(
                      color: Colors.orange,
                      title: 'Continue',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    )
                  : Column(
                      children: [
                        ElevetedButtonWidget(
                          color: Colors.orange,
                          title: 'Next',
                          onPressed: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevetedButtonWidget(
                          color: Colors.white,
                          title: 'Skip',
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
