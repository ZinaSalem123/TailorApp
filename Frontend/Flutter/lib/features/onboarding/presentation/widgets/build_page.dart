import 'package:flutter/material.dart';
import 'package:tailor_app/core/theme/app_styles.dart';

class BuildPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BuildPage({
    key,
    required this.urlImage,
    required this.color,
    required this.title,
    required this.subTitle,
    this.width = 250.0,
  });

  final String urlImage;
  final Color color;
  final String title;
  final String subTitle;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: width,
          ),
          const SizedBox(
            height: 64,
          ),
          Text(
            title,
            style: AppStyles.headlineStyle,
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              subTitle,
              style: AppStyles.bodyTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
