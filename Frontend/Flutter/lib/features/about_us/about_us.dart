//A package in flutt
import 'package:flutter/material.dart';

import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  Widget buildText(String text, TextStyle style) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        text,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "About Us"),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          Center(
            child: Image.asset(
              "assets/images/start2.png",
              width: 180,
            ),
          ),
          const SizedBox(height: 20),
          buildText("About us:", AppStyles.headlineStyle2),
          const SizedBox(height: 10),
          buildText(
            "We are a dedicated team of tailoring and sewing experts committed to delivering precise measurements and high-quality craftsmanship. Our skilled mobile developers work alongside them to ensure a seamless and user-friendly experience, making your journey with us enjoyable and efficient.",
            AppStyles.bodyTextStyle,
          ),
          const SizedBox(height: 10),
          buildText("Developer:", AppStyles.headlineStyle2),
          const SizedBox(height: 10),
          buildText("Name: Zaina Salem Ben Shemla", AppStyles.bodyTextStyle),
          buildText("Department: IT_Level4", AppStyles.bodyTextStyle),
          buildText("Email: zainasalem@gmail.com", AppStyles.bodyTextStyle),
          const SizedBox(height: 20),
          Center(child: buildText("2024-2025", AppStyles.bodyTextStyle)),
        ],
      ),
    );
  }
}
