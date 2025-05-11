import 'package:tailor_app/core/models/local_models/style_model.dart';

class StyleData {
  static List<StyleModel> styles = [
    const StyleModel(
      id: 1,
      title: 'Floral Contrast Skirt',
      imageUrl: 'assets/images/style1.jpg',
      description:
          'Elegant skirt featuring a black and white design with floral prints, perfect for various occasions',
      sizes: 'S-M-XL',
      baseNeed: 2.5,
    ),
    const StyleModel(
      id: 2,
      title: 'Brown Floral Dress',
      imageUrl: 'assets/images/style2.jpg',
      description:
          'Stylish beige dress adorned with brown floral patterns and a waist sash, ideal for social events.',
      sizes: 'S-M-XL',
      baseNeed: 3.0,
    ),
    const StyleModel(
      id: 3,
      title: 'Denim Casual Dress',
      imageUrl: 'assets/images/style4.jpg',
      description:
          'Trendy denim dress with buttons and a belt, perfect for everyday wear.',
      sizes: 'S-M-L',
      baseNeed: 2.0,
    ),
    const StyleModel(
      id: 4,
      title: 'White Bow Dress',
      imageUrl: 'assets/images/style12.jpg',
      description:
          'Elegant white dress with a black bow, perfect for formal events or evening outings.',
      sizes: 'M-L-XL',
      baseNeed: 2.8,
    ),
    const StyleModel(
      id: 5,
      title: 'Blue Floral Wrap Dress',
      imageUrl: 'assets/images/style8.jpg',
      description:
          'Short dress with wide sleeves and floral patterns in blue, suitable for summer outings.',
      sizes: 'M-L-XL',
      baseNeed: 2.8,
    ),
    const StyleModel(
      id: 6,
      title: 'Dark Blue Dress',
      imageUrl: 'assets/images/style11.jpg',
      description:
          'Feminine dark blue dress with elegant details, great for evening occasions.',
      sizes: 'M-L-XL',
      baseNeed: 2.8,
    ),
    const StyleModel(
      id: 7,
      title: ' White Shirt Dress',
      imageUrl: 'assets/images/style6.jpg',
      description:
          'Simple white shirt dress with a stylish belt, offering a modern and chic look.',
      sizes: 'M-L-XL',
      baseNeed: 2.8,
    ),
    const StyleModel(
      id: 8,
      title: 'Ombre Pleated Dress',
      imageUrl: 'assets/images/style7.jpg',
      description:
          'Long dress with ombre colors from black to pink, featuring pleated details for a stylish look.',
      sizes: 'M-L-XL',
      baseNeed: 2.8,
    ),
  ];
}
