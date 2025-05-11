import '../../tables/persons_table.dart';

class PersonModel {
  PersonModel({
    this.id,
    required this.height,
    required this.weight,
    required this.age,
  });

  final int? id;
  final int height;
  final int weight;
  final int age;

  factory PersonModel.fromMap(Map<String, Object?> map) => PersonModel(
        id: map[PersonsTable.id] as int?,
        height: map[PersonsTable.height] as int,
        weight: map[PersonsTable.weight] as int,
        age: map[PersonsTable.age] as int,
      );

  Map<String, Object?> toMap() => {
        if (id != null) PersonsTable.id: id,
        PersonsTable.height: height,
        PersonsTable.weight: weight,
        PersonsTable.age: age,
      };

  // double calculateFabricNeed(double baseNeed) {
  //   double heightFactor = (height > 160) ? 1.1 : 1.0;
  //   double weightFactor = (weight > 70) ? 1.1 : 1.0;
  //   return baseNeed * heightFactor * weightFactor;
  // }

  double calculateFabricNeed(double baseNeed) {
    // The noramlSize = weight/ (heightByMeters)^2
    // double heightByMeters = height / 100;
    // double average = weight / ((height) ^ 2);
    if (height > 160 && weight > 64) {
      return (baseNeed + 1.0);
    }
    if (height > 160 || weight > 64) {
      return (baseNeed + 0.5);
    } else {
      return baseNeed;
    }
  }
}
