class Category {
  final int index;
  static const categories = [
    '5a',
    '5a+',
    '5b',
    '5b+',
    '5c',
    '5c+',
    '6a',
    '6a+',
    '6b',
    '6b+',
    '6c',
    '6c+',
    '7a',
    '7a+',
    '7b',
    '7b+',
    '7c',
    '7c+',
    '8a',
    '8a+',
    '8b',
    '8b+',
    '8c',
    '8c+',
    '9a',
    '9a+',
    '9b',
    '9b+',
    '9c',
    '9c+',
  ];

  Category(String categoryName) : index = categories.indexOf(categoryName);

  factory Category.fromJson(String jsonValue) {
    return Category(jsonValue);
  }

  String toJson() {
    return categories[index];
  }

  @override
  String toString() {
    return categories[index];
  }
}
