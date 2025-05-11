import 'package:flutter/material.dart';
import 'package:tailor_app/core/theme/app_styles.dart'; // Import AppStyles

class DesignCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String availableSizes;
  final VoidCallback onTap;

  const DesignCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.availableSizes,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image)),
              ),
            ),
            Padding(
              padding: AppStyles.cardPadding, // Use constant padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.bodyTextStyle2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Size: $availableSizes',
                    style: textTheme.bodyText2, // Use semantic theme style
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
