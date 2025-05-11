class PersonsTable {
  static String get personsTable => 'persons';
  static String get id => 'id';
  static String get height => 'height';
  static String get weight => 'weight';
  static String get age => 'age';

  static String get create => '''
      CREATE TABLE IF NOT EXISTS `$personsTable` (
            `$id` INTEGER PRIMARY KEY,
            `$height` INTEGER NOT NULL,
            `$weight` INTEGER NOT NULL,
            `$age` INTEGER NOT NULL
       )''';
}
