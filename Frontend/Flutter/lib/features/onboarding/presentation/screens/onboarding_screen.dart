//A package in flutter
import 'package:flutter/material.dart';

//A Package in flutter need to install
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//Core Folder
import '../../../../core/theme/app_styles.dart';

//Features Folders
import '../../../../features/home/presentation/screens/home_screen.dart';
import '../../../../features/onboarding/presentation/widgets/build_page.dart';

class OnboardingPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const OnboardingPage({key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 3;
            });
          },
          children: const [
            BuildPage(
                urlImage: 'assets/images/1.png',
                color: Colors.white,
                title: "Tailor App is a good for you",
                subTitle: "You can Know how much need with your maes"),
            BuildPage(
                urlImage: 'assets/images/2.png',
                color: Colors.white,
                title: "Esay and Fun",
                subTitle: "Don't cere about how will you tacke your maesr."),
            BuildPage(
                urlImage: 'assets/images/3.png',
                color: Colors.white,
                title: "Be Reassured",
                subTitle: "You can check and detail what you love."),
            BuildPage(
                urlImage: 'assets/images/start.png',
                color: Colors.white,
                title: "Let's Go",
                subTitle: "We wish a good and enjoyble experience for you."),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        primary: Colors.black,
                        backgroundColor: AppStyles.primaryColor,
                        maximumSize: const Size.fromHeight(120),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      },
                      child: const Text(
                        'Get Started!',
                        style: AppStyles.buttonTextStyle,
                      ))
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(3);
                      },
                      child: const Text('Skip')),
                  Center(
                    child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        effect: const WormEffect(
                            spacing: 16,
                            dotColor: Colors.grey,
                            activeDotColor: AppStyles.primaryColor),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn)),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: const Text('Next'))
                ],
              ),
            ),
    );
  }
}
