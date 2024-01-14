import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_trip_flutter_app/constant/app_colors.dart';
import 'package:my_trip_flutter_app/constant/app_textstyles.dart';
import 'package:my_trip_flutter_app/presentation/authentication/signup_screen.dart';
import 'onboarding_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  OnboardingState createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                OnboardingPage(
                  title: 'Life is Short and the world is wide',
                  subtitle:
                      'At Friends and travel,we customize reliable and trustworthy educational tour to destinations all over the world',
                  imagePath: 'assets/images/onboard_1.jpg',
                  onPressed: () {},
                ),
                OnboardingPage(
                  title: "It's a big world out there,go explore",
                  subtitle:
                      'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
                  imagePath: 'assets/images/onboard_2.jpg',
                  onPressed: () {},
                ),
                OnboardingPage(
                  title: "People don't like trips,trips take people",
                  subtitle:
                      'To get the best of your adventure you just need to leave and go where you like. we are waiting for you ',
                  imagePath: 'assets/images/onboard_3.jpg',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    width: width/50,
                    height: height/50,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == i ? Colors.blue : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),),
          Container(
            width: width*5/6,
            height: height/15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child:  ElevatedButton(
              onPressed: () {
                if (_currentPage == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                } else {
                  MaterialPageRoute(builder: (context) => const Onboarding());
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor:AppColors.grey.shade900,
                backgroundColor: AppColors.grey.shade900,

              ),
              child: Text(
                  _currentPage == 0 ? 'Get Started' : 'Next',
                  style: AppTextStyles.subtitle(color: AppColors.textColorDark)
              ),
            ),
          ),

          SizedBox(
            height: height/30,
          )
        ],
      ),
    );
  }
}
